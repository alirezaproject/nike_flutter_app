import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/core/extensions/price_label.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/core/widgets/image.dart';
import 'package:nike/features/feature_product/domain/entities/product_entity.dart';
import 'package:nike/features/feature_product/presentation/widgets/comment_list.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 50,
          child: FloatingActionButton.extended(
            onPressed: () {},
            label: Text(
              'افزودن به سبد خرید',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomScrollView(
          physics: Constants.defaultScrollPhysics,
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: LoadImage(image: product.image!, borderRadius: BorderRadius.zero),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.heart),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          product.title!,
                          style: theme.textTheme.titleLarge,
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product.previousPrice!.withPriceLabel(),
                              style: theme.textTheme.bodySmall!.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(product.price!.withPriceLabel()),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا. هیچ فشار مخربی رو نمیذارد به پا و زانوان شما انتقال داده شود',
                      style: TextStyle(height: 1.4),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ثبت نظرات کاربران",
                          style: theme.textTheme.titleMedium,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('ثبت نظر'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CommentList(productId: product.id!),
          ],
        ),
      ),
    );
  }
}
