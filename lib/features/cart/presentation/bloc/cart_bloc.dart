import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nike/core/params/change_cart_count_params.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/auth/data/models/auth_model.dart';
import 'package:nike/features/cart/domain/entities/cart_entity.dart';
import 'package:nike/features/cart/domain/usecases/cart_change_count_usecase.dart';
import 'package:nike/features/cart/domain/usecases/delete_cart_item_usecase.dart';
import 'package:nike/features/cart/domain/usecases/get_cart_count_item_usecase.dart';
import 'package:nike/features/cart/domain/usecases/get_cart_list_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartListUseCase _getCartListUseCase;
  final DeleteCartItemUseCase _deleteCartItemUseCase;
  final CartChangeCountUseCase _cartChangeCountUseCase;
  final GetCartCountItemUseCase _getCartCountItemUseCase;
  CartBloc(this._getCartListUseCase, this._deleteCartItemUseCase,
      this._cartChangeCountUseCase, this._getCartCountItemUseCase)
      : super(CartLoading()) {
    on<LoadCart>((event, emit) async {
      final authinfo = event.authModel;
      if (authinfo == null || authinfo.accessToken.isEmpty) {
        emit(CartAuthRequired());
      } else {
        await _loadCartItems(emit, event.isRefresh);
      }
    });
    on<CartAuthInfoChanged>((event, emit) async {
      final authinfo = event.authModel;
      if (authinfo == null || authinfo.accessToken.isEmpty) {
        emit(CartAuthRequired());
      } else {
        if (state is CartAuthRequired) {
          await _loadCartItems(emit, false);
        }
      }
    });

    on<ClickDeleteCartEvent>((event, emit) async {
      try {
        if (state is CartSuccess) {
          final successState = (state as CartSuccess);
          final cartItem = successState.cart.cartItems!.firstWhere(
            (element) => element.cartItemId == event.cartItemId,
          );
          cartItem.deleteButtonLoading = true;
          emit(CartSuccess(cart: successState.cart));
          await _deleteCartItemUseCase(cartItem.cartItemId!);
          await _getCartCountItemUseCase();
        }

        if (state is CartSuccess) {
          final successState = (state as CartSuccess);
          successState.cart.cartItems!
              .removeWhere((element) => element.cartItemId == event.cartItemId);
          if (successState.cart.cartItems!.isEmpty) {
            emit(CartEmptyState());
          } else {
            emit(calculatePriceInfo(successState.cart));
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });

    on<ClickIncreaseCountButton>((event, emit) async {
      try {
        if (state is CartSuccess) {
          final successState = (state as CartSuccess);
          final cartItem = successState.cart.cartItems!.firstWhere(
            (element) => element.cartItemId == event.cartItemId,
          );
          cartItem.changeCountLoading = true;
          emit(CartSuccess(cart: successState.cart));
          final newCount = cartItem.count! + 1;
          await _cartChangeCountUseCase(
            ChangeCartCountParams(
                cartItemId: cartItem.cartItemId!, count: newCount),
          );
          await _getCartCountItemUseCase();
          successState.cart.cartItems!
              .firstWhere((element) => element.cartItemId == event.cartItemId)
              .count = newCount;
          cartItem.changeCountLoading = false;
          emit(calculatePriceInfo(successState.cart));
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<ClickDecreaseCountButton>((event, emit) async {
      try {
        if (state is CartSuccess) {
          final successState = (state as CartSuccess);
          final cartItem = successState.cart.cartItems!.firstWhere(
            (element) => element.cartItemId == event.cartItemId,
          );
          cartItem.changeCountLoading = true;
          emit(CartSuccess(cart: successState.cart));
          final newCount = cartItem.count! - 1;

          await _cartChangeCountUseCase(
            ChangeCartCountParams(
                cartItemId: cartItem.cartItemId!, count: newCount),
          );
          await _getCartCountItemUseCase();
          successState.cart.cartItems!
              .firstWhere((element) => element.cartItemId == event.cartItemId)
              .count = newCount;

          cartItem.changeCountLoading = false;
          emit(calculatePriceInfo(successState.cart));
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  Future<void> _loadCartItems(Emitter<CartState> emit, bool isRefresh) async {
    try {
      if (!isRefresh) {
        emit(CartLoading());
      }

      final cart = await _getCartListUseCase();
      if (cart.cartItems!.isEmpty) {
        emit(CartEmptyState());
      } else {
        emit(CartSuccess(cart: cart));
      }
    } catch (e) {
      emit(CartError(exception: AppException()));
    }
  }

  CartSuccess calculatePriceInfo(CartEntity cart) {
    int totalPrice = 0;
    int payablePrice = 0;
    int shippingCost = 0;

    for (var element in cart.cartItems!) {
      totalPrice += element.product!.previousPrice! * element.count!;
      payablePrice += element.product!.price! * element.count!;
    }

    shippingCost = payablePrice >= 250000 ? 0 : 30000;

    cart.totalPrice = totalPrice;
    cart.payablePrice = payablePrice;
    cart.shippingCost = shippingCost;
    return CartSuccess(cart: cart);
  }
}
