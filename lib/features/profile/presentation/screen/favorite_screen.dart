import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nike/core/extensions/price_label.dart';
import 'package:nike/core/widgets/image.dart';
import 'package:nike/features/product/data/data_source/local/favorite_manager.dart';
import 'package:nike/features/product/domain/entities/product_entity.dart';
import 'package:nike/features/product/presentation/screens/product_detail_screen.dart';
import 'package:nike/service_locator.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('لیست علاقه مندی ها'),
      ),
      body: ValueListenableBuilder<Box<ProductEntity>>(
        valueListenable: FavoriteManager.listenable,
        builder: (context, box, child) {
          final products = box.values.toList();
          return ListView.builder(
            itemCount: products.length,
            padding: const EdgeInsets.only(top: 8, bottom: 100),
            itemBuilder: (BuildContext context, int index) {
              final product = products[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(product: product),
                    ),
                  );
                },
                onLongPress: () {
                  FavoriteManager favoriteManager = sl();
                  favoriteManager.delete(product);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 110,
                        height: 110,
                        child: LoadImage(
                          image: product.image!,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title!,
                                style: theme.textTheme.titleMedium!
                                    .apply(color: theme.colorScheme.primary),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Text(
                                product.previousPrice!.withPriceLabel,
                                style: theme.textTheme.bodySmall!.apply(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Text(product.price!.withPriceLabel),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
