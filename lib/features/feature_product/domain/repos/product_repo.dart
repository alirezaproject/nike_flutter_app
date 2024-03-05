import 'package:nike/core/resources/data_state.dart';
import 'package:nike/features/feature_product/domain/entities/product_entity.dart';

abstract class ProductRepo {
  Future<DataState<List<ProductEntity>>> getProductList(int sort);
}
