import 'package:nike/features/shipping/domain/entity/order_history_entity.dart';

import 'order_item.dart';

class OrderHistoryModel extends OrderHistoryEntity {
  int? id;
  String? firstName;
  String? lastName;
  String? postalCode;
  String? phone;
  String? address;
  int? payable;
  int? total;
  int? shippingCost;
  String? paymentStatus;
  String? paymentMethod;
  int? userId;
  String? date;
  List<OrderItem>? orderItems;

  OrderHistoryModel({
    this.id,
    this.firstName,
    this.lastName,
    this.postalCode,
    this.phone,
    this.address,
    this.payable,
    this.total,
    this.shippingCost,
    this.paymentStatus,
    this.paymentMethod,
    this.userId,
    this.date,
    this.orderItems,
  }) : super(
            id: id,
            firstName: firstName,
            lastName: lastName,
            postalCode: postalCode,
            phone: phone,
            address: address,
            payable: payable,
            total: total,
            shippingCost: shippingCost,
            paymentStatus: paymentStatus,
            paymentMethod: paymentMethod,
            userId: userId,
            date: date,
            orderItems: orderItems);

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'] as int?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      postalCode: json['postal_code'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      payable: json['payable'] as int?,
      total: json['total'] as int?,
      shippingCost: json['shipping_cost'] as int?,
      paymentStatus: json['payment_status'] as String?,
      paymentMethod: json['payment_method'] as String?,
      userId: json['user_id'] as int?,
      date: json['date'] as String?,
      orderItems: (json['order_items'] as List<dynamic>?)?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'postal_code': postalCode,
        'phone': phone,
        'address': address,
        'payable': payable,
        'total': total,
        'shipping_cost': shippingCost,
        'payment_status': paymentStatus,
        'payment_method': paymentMethod,
        'user_id': userId,
        'date': date,
        'order_items': orderItems?.map((e) => e.toJson()).toList(),
      };
}
