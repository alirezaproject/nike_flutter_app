part of 'product_list_bloc.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

final class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<ProductEntity> products;
  final int sort;
  final List<String> sortNames;

  const ProductListLoaded({required this.products, required this.sort, required this.sortNames});

  @override
  List<Object> get props => [products, sort];
}

class ProductListError extends ProductListState {
  final AppException error;

  const ProductListError(this.error);

  @override
  List<Object> get props => [error];
}
