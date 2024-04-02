import 'package:flutter/material.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/core/widgets/product/product_item.dart';
import 'package:nike/features/product/domain/entities/product_entity.dart';

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
          height: 300,
          child: ListView.builder(
            physics: Constants.defaultScrollPhysics,
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 8, right: 8),
            itemBuilder: (BuildContext context, int index) {
              final product = products[index];
              return ProductItem(
                product: product,
                theme: theme,
                borderRadius: BorderRadius.circular(12),
              );
            },
          ),
        ),
      ],
    );
  }
}
