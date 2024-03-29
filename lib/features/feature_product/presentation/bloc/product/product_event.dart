part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class AddCartButtonClick extends ProductEvent {
  final int productId;

  const AddCartButtonClick({required this.productId});
}
