import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/product/domain/entities/product_entity.dart';
import 'package:nike/features/product/domain/use_cases/get_product_list_usecase.dart';
import 'package:nike/features/product/domain/use_cases/search_product_list_usecase.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductListUseCase _getProductListUseCase;
  final SearchProductListUseCase _searchProductListUseCase;
  ProductListBloc(this._getProductListUseCase, this._searchProductListUseCase) : super(ProductListInitial()) {
    on<ProductListStarted>((event, emit) async {
      try {
        emit(ProductListLoading());
        final products = event.searchTerm.isEmpty ? await _getProductListUseCase(event.sort) : await _searchProductListUseCase(event.searchTerm);
        if (products.data!.isNotEmpty) {
          emit(ProductListLoaded(products: products.data!, sort: event.sort, sortNames: ProductSort.names));
        } else {
          emit(const ProductListEmpty(message: 'محصولی یافت نشد'));
        }
      } catch (e) {
        emit(ProductListError(AppException()));
      }
    });
  }
}
