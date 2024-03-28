import 'package:nike/features/feature_cart/data/models/cart_model/cart_item.dart';

class CartEntity {
  final List<CartItem>? cartItems;
  final int? payablePrice;
  final int? totalPrice;
  final int? shippingCost;

  CartEntity({required this.cartItems, required this.payablePrice, required this.totalPrice, required this.shippingCost});
}
