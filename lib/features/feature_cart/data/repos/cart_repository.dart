import 'package:dio/dio.dart';
import 'package:nike/core/utils/http_validator.dart';
import 'package:nike/features/feature_cart/data/models/cart_model/cart_model.dart';
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
  Future delete(int cartItemId) async {
    Response response = await _cartApiService.delete(cartItemId);
    validateResponse(response);
  }

  @override
  Future<CartEntity> list() async {
    Response response = await _cartApiService.list();
    validateResponse(response);
    CartEntity cartEntity = CartModel.fromJson(response.data);
    // (response.data as List)
    //    .map((json) => CartModel.fromJson(json))
    //    .map(
    //      (e) => CartEntity(
    //        cartItems: e.cartItems,
    //        payablePrice: e.payablePrice,
    //        totalPrice: e.totalPrice,
    //        shippingCost: e.shippingCost,
    //      ),
    //    )
    //    .toList();

    return cartEntity;
  }
}
