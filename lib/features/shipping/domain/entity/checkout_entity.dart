class CheckoutEntity {
  final bool? purchaseSuccess;
  final int? payablePrice;
  final String? paymentStatus;

  CheckoutEntity(this.purchaseSuccess, this.payablePrice, this.paymentStatus);
}
