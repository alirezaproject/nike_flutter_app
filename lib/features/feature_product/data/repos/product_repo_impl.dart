import 'package:nike/core/resources/data_state.dart';
import 'package:nike/features/feature_product/domain/entities/product_entity.dart';
import 'package:nike/features/feature_product/domain/repos/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  @override
  Future<DataState<List<ProductEntity>>> getProductList(int sort) {
    throw UnimplementedError();
  }
}
