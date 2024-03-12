import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nike/core/extensions/price_label.dart';
import 'package:nike/core/widgets/image.dart';
import 'package:nike/features/feature_product/domain/entities/product_entity.dart';

class HorizontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductEntity> products;
  const HorizontalProductList({
    super.key,
    required this.title,
    required this.onTap,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium,
              ),
              TextButton(
                onPressed: onTap,
                child: Text(
                  'مشاهده همه',
                  style: theme.textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 8, right: 8),
            itemBuilder: (BuildContext context, int index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 176,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 176,
                            height: 189,
                            child: LoadImage(
                              image: product.image!,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                              alignment: Alignment.center,
                              child: Icon(
                                CupertinoIcons.heart,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(product.title!, overflow: TextOverflow.ellipsis, maxLines: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8),
                        child: Text(
                          product.previousPrice!.withPriceLabel(),
                          style: theme.textTheme.bodySmall!.copyWith(decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 8, top: 4),
                        child: Text(product.price!.withPriceLabel()),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
