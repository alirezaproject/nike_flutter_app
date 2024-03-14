import 'package:dio/dio.dart';
import 'package:nike/core/resources/data_state.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/core/utils/http_validator.dart';
import 'package:nike/features/feature_product/data/data_source/remote/product_api_service.dart';
import 'package:nike/features/feature_product/data/model/product_model/product_model.dart';
import 'package:nike/features/feature_product/domain/entities/product_entity.dart';
import 'package:nike/features/feature_product/domain/repository/product_repository.dart';

class ProductRepository with HttpValidator implements IProductRepository {
  final ProductApiService _productApiService;

  ProductRepository(this._productApiService);
  @override
  Future<DataState<List<ProductEntity>>> getProductList(int sort) async {
    try {
      Response response = await _productApiService.getProductList(sort);
      validateResponse(response);

      List<ProductEntity> productEntity = (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .map((productModel) {
        return ProductEntity(
          id: productModel.id,
          title: productModel.title,
          price: productModel.price,
          discount: productModel.discount,
          image: productModel.image,
          status: productModel.status,
          previousPrice: productModel.previousPrice,
        );
      }).toList();

      return DataSuccess(productEntity);
    } catch (e) {
      throw AppException();
    }
  }

  @override
  Future<DataState<List<ProductEntity>>> search(String search) async {
    try {
      Response response = await _productApiService.searchProduct(search);
      validateResponse(response);

      List<ProductEntity> productEntity = (response.data as List)
          .map((json) => ProductModel.fromJson(json))
          .map((e) => ProductEntity(
                id: e.id,
                title: e.title,
                price: e.price,
                discount: e.discount,
                image: e.image,
                status: e.status,
                previousPrice: e.previousPrice,
              ))
          .toList();

      return DataSuccess(productEntity);
    } catch (e) {
      throw AppException();
    }
  }
}
