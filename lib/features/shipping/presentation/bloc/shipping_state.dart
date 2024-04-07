part of 'shipping_bloc.dart';

sealed class ShippingState extends Equatable {
  const ShippingState();

  @override
  List<Object> get props => [];
}

final class ShippingInitial extends ShippingState {}

final class ShippingLoading extends ShippingState {}

final class ShippingLoaded extends ShippingState {
  final OrderEntity result;

  const ShippingLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

final class ShippingError extends ShippingState {
  final AppException error;

  const ShippingError(this.error);

  @override
  List<Object> get props => [error];
}
