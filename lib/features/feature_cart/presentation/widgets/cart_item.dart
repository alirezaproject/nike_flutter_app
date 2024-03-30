import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/core/extensions/price_label.dart';
import 'package:nike/core/widgets/image.dart';
import 'package:nike/features/feature_cart/data/models/cart_model/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.theme,
    required this.cart,
    required this.onDeleteButtonClick,
  });

  final ThemeData theme;
  final CartItem cart;
  final GestureTapCallback onDeleteButtonClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: LoadImage(
                    image: cart.product!.image!,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      cart.product!.title!,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('تعداد'),
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.plus_rectangle)),
                        Text(cart.count!.toString(), style: theme.textTheme.titleLarge),
                        IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.minus_rectangle)),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      cart.product!.previousPrice!.withPriceLabel(),
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                    Text(
                      cart.product!.price!.withPriceLabel(),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          cart.deleteButtonLoading
              ? SizedBox(
                  height: 48,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                )
              : TextButton(
                  onPressed: onDeleteButtonClick,
                  child: Text('حذف از سبد خرید'),
                ),
        ],
      ),
    );
  }
}
