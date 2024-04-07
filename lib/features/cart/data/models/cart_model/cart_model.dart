import 'package:nike/features/cart/domain/entities/cart_entity.dart';

import 'cart_item.dart';

class CartModel extends CartEntity {
  final List<CartItem>? cartItems;
  int? payablePrice;
  int? totalPrice;
  int? shippingCost;

  CartModel({
    this.cartItems,
    this.payablePrice,
    this.totalPrice,
    this.shippingCost,
  }) : super(
            cartItems: null,
            payablePrice: null,
            totalPrice: null,
            shippingCost: null);

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        cartItems: (json['cart_items'] as List<dynamic>?)
            ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        payablePrice: json['payable_price'] as int?,
        totalPrice: json['total_price'] as int?,
        shippingCost: json['shipping_cost'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'cart_items': cartItems?.map((e) => e.toJson()).toList(),
        'payable_price': payablePrice,
        'total_price': totalPrice,
        'shipping_cost': shippingCost,
      };
}
