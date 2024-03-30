part of 'cart_bloc.dart';

abstract class CartState {
  const CartState();
}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartEntity cart;

  const CartSuccess({required this.cart});
}

class CartError extends CartState {
  final AppException exception;

  const CartError({required this.exception});
}

class CartAuthRequired extends CartState {}

class CartEmptyState extends CartState {}
