import 'package:nike/features/feature_cart/domain/entities/cart_entity.dart';
import 'package:nike/features/feature_cart/domain/entities/cart_response_entity.dart';

abstract class ICartRepository {
  Future<CartResponseEntity> add(int productId);
  Future<CartResponseEntity> changeCount(int cartItemId, int count);
  Future delete(int cartItemId);
  Future<int> count();
  Future<CartEntity> list();
}
