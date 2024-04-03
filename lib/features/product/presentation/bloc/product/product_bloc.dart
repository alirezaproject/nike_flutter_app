import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:nike/features/cart/domain/usecases/get_cart_count_item_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddToCartUseCase _addToCartUseCase;
  final GetCartCountItemUseCase _getCartCountItemUseCase;
  ProductBloc(this._addToCartUseCase, this._getCartCountItemUseCase) : super(ProductInitial()) {
    on<AddCartButtonClick>((event, emit) async {
      try {
        emit(ProductAddToCartButtonLoading());
        await _addToCartUseCase(event.productId);
        await _getCartCountItemUseCase();
        emit(ProductAddToCartButtonSuccess());
      } catch (e) {
        emit(ProductAddToCartButtonError(exception: AppException()));
      }
    });
  }
}
