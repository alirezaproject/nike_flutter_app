import 'package:nike/features/cart/data/models/cart_model/cart_item.dart';

class CartEntity {
  final List<CartItem>? cartItems;
  int? payablePrice;
  int? totalPrice;
  int? shippingCost;

  CartEntity({required this.cartItems, required this.payablePrice, required this.totalPrice, required this.shippingCost});
}
