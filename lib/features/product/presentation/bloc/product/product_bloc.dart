import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/cart/domain/usecases/add_to_cart_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddToCartUseCase _addToCartUseCase;
  ProductBloc(this._addToCartUseCase) : super(ProductInitial()) {
    on<AddCartButtonClick>((event, emit) async {
      try {
        emit(ProductAddToCartButtonLoading());
        await _addToCartUseCase(event.productId);
        emit(ProductAddToCartButtonSuccess());
      } catch (e) {
        emit(ProductAddToCartButtonError(exception: AppException()));
      }
    });
  }
}
