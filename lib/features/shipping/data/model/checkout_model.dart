import 'package:nike/features/shipping/domain/entity/checkout_entity.dart';

class CheckoutModel extends CheckoutEntity {
  bool? purchaseSuccess;
  int? payablePrice;
  String? paymentStatus;

  CheckoutModel({
    this.purchaseSuccess,
    this.payablePrice,
    this.paymentStatus,
  }) : super(false, 0, '');

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
        purchaseSuccess: json['purchase_success'] as bool?,
        payablePrice: json['payable_price'] as int?,
        paymentStatus: json['payment_status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'purchase_success': purchaseSuccess,
        'payable_price': payablePrice,
        'payment_status': paymentStatus,
      };
}
