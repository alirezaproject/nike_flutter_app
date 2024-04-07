class CreateOrderParams {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String postalCode;
  final String address;
  final PaymentMethod paymenyMethod;

  CreateOrderParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.postalCode,
    required this.address,
    required this.paymenyMethod,
  });
}

enum PaymentMethod {
  online,
  cashOnDelivery,
}
