import 'package:nike/features/shipping/domain/entity/order_entity.dart';

class OrderModel extends OrderEntity {
  int? orderId;
  String? bankGatewayUrl;

  OrderModel({this.orderId, this.bankGatewayUrl}) : super(0, '');

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: json['order_id'] as int?,
        bankGatewayUrl: json['bank_gateway_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'bank_gateway_url': bankGatewayUrl,
      };
}
