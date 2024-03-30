import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/feature_auth/data/models/auth_model.dart';
import 'package:nike/features/feature_cart/domain/entities/cart_entity.dart';
import 'package:nike/features/feature_cart/domain/usecases/delete_cart_item_usecase.dart';
import 'package:nike/features/feature_cart/domain/usecases/get_cart_list_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartListUseCase _getCartListUseCase;
  final DeleteCartItemUseCase _deleteCartItemUseCase;
  CartBloc(this._getCartListUseCase, this._deleteCartItemUseCase) : super(CartLoading()) {
    on<LoadCart>((event, emit) async {
      final authinfo = event.authModel;
      if (authinfo == null || authinfo.accessToken.isEmpty) {
        emit(CartAuthRequired());
      } else {
        await _loadCartItems(emit);
      }
    });
    on<CartAuthInfoChanged>((event, emit) async {
      final authinfo = event.authModel;
      if (authinfo == null || authinfo.accessToken.isEmpty) {
        emit(CartAuthRequired());
      } else {
        if (state is CartAuthRequired) {
          await _loadCartItems(emit);
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
        }

        if (state is CartSuccess) {
          final successState = (state as CartSuccess);
          successState.cart.cartItems!.removeWhere((element) => element.cartItemId == event.cartItemId);
          if (successState.cart.cartItems!.isEmpty) {
            emit(CartEmptyState());
          } else {
            emit(CartSuccess(cart: successState.cart));
          }
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  Future<void> _loadCartItems(Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
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
}
