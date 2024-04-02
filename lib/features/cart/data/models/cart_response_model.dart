import 'package:nike/features/cart/domain/entities/cart_response_entity.dart';

class CartResponseModel extends CartResponseEntity {
  final int? productId;
  final int? count;
  final int? id;

  CartResponseModel({this.productId, this.count, this.id}) : super(0, 0, 0);

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      productId: json['product_id'] as int?,
      count: json['count'] as int?,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'count': count,
        'id': id,
      };
}
