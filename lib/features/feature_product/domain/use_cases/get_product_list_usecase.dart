import 'package:nike/core/resources/data_state.dart';
import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/feature_product/domain/entities/product_entity.dart';
import 'package:nike/features/feature_product/domain/repository/product_repository.dart';

class GetProductListUseCase extends UseCase<DataState<List<ProductEntity>>, int> {
  final IProductRepository _productRepository;

  GetProductListUseCase(this._productRepository);
  @override
  Future<DataState<List<ProductEntity>>> call(int params) async => await _productRepository.getProductList(params);
}
