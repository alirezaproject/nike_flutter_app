import 'package:nike/features/product/data/model/product_model/product_model.dart';

class CartItem {
  final int? cartItemId;
  final ProductModel? product;
  int? count;
  bool deleteButtonLoading = false;
  bool changeCountLoading = false;

  CartItem({this.cartItemId, this.product, this.count});

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        cartItemId: json['cart_item_id'] as int?,
        product: json['product'] == null
            ? null
            : ProductModel.fromJson(
                json['product'] as Map<String, dynamic>,
              ),
        count: json['count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'cart_item_id': cartItemId,
        'product': product?.toJson(),
        'count': count,
      };
}
