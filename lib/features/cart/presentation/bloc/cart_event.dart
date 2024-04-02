part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class LoadCart extends CartEvent {
  final AuthModel? authModel;
  final bool isRefresh;

  const LoadCart({required this.authModel, this.isRefresh = false});
}

class ClickDeleteCartEvent extends CartEvent {
  final int cartItemId;

  const ClickDeleteCartEvent({required this.cartItemId});
}

class CartAuthInfoChanged extends CartEvent {
  final AuthModel? authModel;

  const CartAuthInfoChanged({required this.authModel});
}

class ClickIncreaseCountButton extends CartEvent {
  final int cartItemId;

  ClickIncreaseCountButton({required this.cartItemId});
}

class ClickDecreaseCountButton extends CartEvent {
  final int cartItemId;

  ClickDecreaseCountButton({required this.cartItemId});
}
