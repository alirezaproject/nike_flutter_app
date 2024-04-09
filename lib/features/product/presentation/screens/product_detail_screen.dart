import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/core/extensions/price_label.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/core/widgets/image.dart';
import 'package:nike/features/product/presentation/widgets/insert_comment_dialog.dart';
import 'package:nike/service_locator.dart';
import 'package:nike/features/product/domain/entities/product_entity.dart';
import 'package:nike/features/product/presentation/bloc/product/product_bloc.dart';
import 'package:nike/features/product/presentation/widgets/comment_list.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductEntity product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  StreamSubscription<ProductState>? stateSubscription;
  @override
  void dispose() {
    stateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) {
          final bloc = sl<ProductBloc>();
          stateSubscription = bloc.stream.listen((state) {
            if (state is ProductAddToCartButtonSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('با موفقیت به سبد خرید شما اضافه شد'),
                ),
              );
            } else if (state is ProductAddToCartButtonError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.exception.message),
                ),
              );
            }
          });
          return bloc;
        },
        child: Scaffold(
          floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return FloatingActionButton.extended(
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context).add(AddCartButtonClick(productId: widget.product.id!));
                  },
                  label: (state is ProductAddToCartButtonLoading)
                      ? CupertinoActivityIndicator(
                          color: theme.colorScheme.onSecondary,
                        )
                      : const Text(
                          'افزودن به سبد خرید',
                          style: TextStyle(color: Colors.white),
                        ),
                );
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: CustomScrollView(
            physics: Constants.defaultScrollPhysics,
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width * 0.8,
                flexibleSpace: LoadImage(image: widget.product.image!, borderRadius: BorderRadius.zero),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.heart),
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
                            widget.product.title!,
                            style: theme.textTheme.titleLarge,
                          )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.product.previousPrice!.withPriceLabel,
                                style: theme.textTheme.bodySmall!.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              Text(widget.product.price!.withPriceLabel),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا. هیچ فشار مخربی رو نمیذارد به پا و زانوان شما انتقال داده شود',
                        style: TextStyle(height: 1.4),
                      ),
                      const SizedBox(
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
                            onPressed: () {
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                context: context,
                                useRootNavigator: true,
                                builder: (context) {
                                  return InsertCommentDialog(
                                    productId: widget.product.id!,
                                    scaffoldMessengerState: scaffoldKey.currentState,
                                  );
                                },
                              );
                            },
                            child: const Text('ثبت نظر'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CommentList(productId: widget.product.id!),
            ],
          ),
        ),
      ),
    );
  }
}
