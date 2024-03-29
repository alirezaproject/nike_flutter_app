part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductAddToCartButtonLoading extends ProductState {}

class ProductAddToCartButtonSuccess extends ProductState {}

class ProductAddToCartButtonError extends ProductState {
  final AppException exception;

  const ProductAddToCartButtonError({required this.exception});

  @override
  List<Object> get props => [exception];
}
