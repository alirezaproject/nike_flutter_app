part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  final AuthModel? authModel;

  const LoadCart({required this.authModel});
}

class CartAuthInfoChanged extends CartEvent {
  final AuthModel? authModel;

  const CartAuthInfoChanged({required this.authModel});
}
