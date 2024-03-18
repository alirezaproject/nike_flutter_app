import 'package:dio/dio.dart';
import 'package:nike/core/utils/http_validator.dart';
import 'package:nike/features/feature_cart/data/models/cart_response_model.dart';
import 'package:nike/features/feature_cart/data/source/remote/cart_api_service.dart';
import 'package:nike/features/feature_cart/domain/entities/cart_entity.dart';
import 'package:nike/features/feature_cart/domain/entities/cart_response_entity.dart';
import 'package:nike/features/feature_cart/domain/repos/cart_repository.dart';

class CartRepository extends ICartRepository with HttpValidator {
  final CartApiService _cartApiService;

  CartRepository(this._cartApiService);

  @override
  Future<CartResponseEntity> add(int productId) async {
    Response response = await _cartApiService.add(productId);
    validateResponse(response);
    return CartResponseModel.fromJson(response.data);
  }

  @override
  Future<CartResponseEntity> changeCount(int cartItemId, int count) {
    // TODO: implement changeCount
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future delete(int cartItemId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CartEntity>> list() {
    // TODO: implement list
    throw UnimplementedError();
  }
}
