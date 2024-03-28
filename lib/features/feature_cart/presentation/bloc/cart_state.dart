part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartEntity cart;

  const CartSuccess({required this.cart});

  @override
  List<Object> get props => [cart];
}

class CartError extends CartState {
  final AppException exception;

  const CartError({required this.exception});
}

class CartAuthRequired extends CartState {}
