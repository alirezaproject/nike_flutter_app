part of 'checkout_bloc.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutLoaded extends CheckoutState {
  final CheckoutEntity checkout;

  const CheckoutLoaded(this.checkout);

  @override
  List<Object> get props => [checkout];
}

final class CheckoutError extends CheckoutState {
  final AppException error;

  const CheckoutError(this.error);

  @override
  List<Object> get props => [error];
}
