part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class LoadCart extends CartEvent {
  final AuthModel? authModel;

  const LoadCart({required this.authModel});
}

class ClickDeleteCartEvent extends CartEvent {
  final int cartItemId;

  const ClickDeleteCartEvent({required this.cartItemId});
}

class CartAuthInfoChanged extends CartEvent {
  final AuthModel? authModel;

  const CartAuthInfoChanged({required this.authModel});
}
