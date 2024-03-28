import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/feature_auth/data/models/auth_model.dart';
import 'package:nike/features/feature_cart/domain/entities/cart_entity.dart';
import 'package:nike/features/feature_cart/domain/usecases/get_cart_list_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartListUseCase _getCartListUseCase;
  CartBloc(this._getCartListUseCase) : super(CartLoading()) {
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
  }

  Future<void> _loadCartItems(Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
      final cart = await _getCartListUseCase();
      emit(CartSuccess(cart: cart));
    } catch (e) {
      emit(CartError(exception: AppException()));
    }
  }
}
