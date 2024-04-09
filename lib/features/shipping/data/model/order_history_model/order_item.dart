import 'package:nike/features/product/data/model/product_model/product_model.dart';

class OrderItem {
  int? id;
  int? orderId;
  int? productId;
  int? count;
  int? price;
  int? discount;
  ProductModel? product;

  OrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.count,
    this.price,
    this.discount,
    this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json['id'] as int?,
        orderId: json['order_id'] as int?,
        productId: json['product_id'] as int?,
        count: json['count'] as int?,
        price: json['price'] as int?,
        discount: json['discount'] as int?,
        product: json['product'] == null ? null : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_id': orderId,
        'product_id': productId,
        'count': count,
        'price': price,
        'discount': discount,
        'product': product?.toJson(),
      };
}
