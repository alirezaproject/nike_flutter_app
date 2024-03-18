import 'package:nike/features/feature_cart/domain/entities/cart_entity.dart';
import 'package:nike/features/feature_product/data/model/product_model/product_model.dart';

class CartItem extends CartEntity {
  final int? cartItemId;
  final ProductModel? product;
  final int? count;

  CartItem({this.cartItemId, this.product, this.count}) : super(null, 0, 0, 0);

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        cartItemId: json['cart_item_id'] as int?,
        product: json['product'] == null ? null : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
        count: json['count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'cart_item_id': cartItemId,
        'product': product?.toJson(),
        'count': count,
      };
}
