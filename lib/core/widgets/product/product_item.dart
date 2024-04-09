import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike/core/extensions/price_label.dart';
import 'package:nike/core/widgets/image.dart';
import 'package:nike/features/product/data/data_source/local/favorite_manager.dart';
import 'package:nike/features/product/domain/entities/product_entity.dart';
import 'package:nike/features/product/presentation/screens/product_detail_screen.dart';
import 'package:nike/service_locator.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.theme,
    required this.borderRadius,
    this.itemWidth = 176,
    this.itemHeight = 189,
  });

  final ProductEntity product;
  final ThemeData theme;
  final BorderRadius borderRadius;
  final double itemWidth;
  final double itemHeight;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  FavoriteManager favorite = sl();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        borderRadius: widget.borderRadius,
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
            product: widget.product,
          ),
        )),
        child: SizedBox(
          width: widget.itemWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 0.93,
                    child: LoadImage(
                      image: widget.product.image!,
                      borderRadius: widget.borderRadius,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: InkWell(
                      onTap: () {
                        if (favorite.isFavorite(widget.product)) {
                          favorite.delete(widget.product);
                        } else {
                          favorite.addFavorite(widget.product);
                        }

                        setState(() {});
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        alignment: Alignment.center,
                        child: Icon(
                          favorite.isFavorite(widget.product)
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.product.title!,
                    overflow: TextOverflow.ellipsis, maxLines: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8),
                child: Text(
                  widget.product.previousPrice!.withPriceLabel,
                  style: widget.theme.textTheme.bodySmall!
                      .copyWith(decoration: TextDecoration.lineThrough),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8, top: 4),
                child: Text(widget.product.price!.withPriceLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
