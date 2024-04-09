import 'package:nike/features/shipping/data/model/order_history_model/order_item.dart';

class OrderHistoryEntity {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? postalCode;
  final String? phone;
  final String? address;
  final int? payable;
  final int? total;
  final int? shippingCost;
  final String? paymentStatus;
  final String? paymentMethod;
  final int? userId;
  final String? date;
  final List<OrderItem>? orderItems;

  OrderHistoryEntity(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.postalCode,
      required this.phone,
      required this.address,
      required this.payable,
      required this.total,
      required this.shippingCost,
      required this.paymentStatus,
      required this.paymentMethod,
      required this.userId,
      required this.date,
      required this.orderItems});
}
