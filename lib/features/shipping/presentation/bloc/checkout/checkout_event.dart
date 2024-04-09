part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class CheckoutStarted extends CheckoutEvent {
  final int orderId;

  const CheckoutStarted(this.orderId);
  @override
  List<Object> get props => [orderId];
}
