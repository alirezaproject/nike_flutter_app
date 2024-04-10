import 'package:nike/core/resources/data_state.dart';
import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/product/domain/entities/product_entity.dart';
import 'package:nike/features/product/domain/repository/product_repository.dart';

class SearchProductListUseCase extends UseCase<DataState<List<ProductEntity>>, String> {
  final IProductRepository _productRepository;

  SearchProductListUseCase(this._productRepository);
  @override
  Future<DataState<List<ProductEntity>>> call(String params) async => await _productRepository.search(params);
}
