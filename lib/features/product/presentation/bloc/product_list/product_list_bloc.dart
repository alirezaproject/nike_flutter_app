import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/product/domain/entities/product_entity.dart';
import 'package:nike/features/product/domain/use_cases/get_product_list_usecase.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductListUseCase _getProductListUseCase;
  ProductListBloc(this._getProductListUseCase) : super(ProductListInitial()) {
    on<ProductListStarted>((event, emit) async {
      try {
        emit(ProductListLoading());
        final products = await _getProductListUseCase(event.sort);
        emit(ProductListLoaded(
            products: products.data!,
            sort: event.sort,
            sortNames: ProductSort.names));
      } catch (e) {
        emit(ProductListError(AppException()));
      }
    });
  }
}
