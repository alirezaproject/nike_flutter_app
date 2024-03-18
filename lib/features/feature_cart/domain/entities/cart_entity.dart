import 'package:nike/features/feature_cart/data/models/cart_model/cart_item.dart';
import 'package:nike/features/feature_cart/data/models/cart_model/cart_model.dart';

class CartEntity extends CartModel {
  final List<CartItem>? cartItems;
  final int? payablePrice;
  final int? totalPrice;
  final int? shippingCost;

  CartEntity(this.cartItems, this.payablePrice, this.totalPrice, this.shippingCost);
}
