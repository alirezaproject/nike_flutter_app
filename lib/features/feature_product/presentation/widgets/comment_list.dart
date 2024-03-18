import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/core/widgets/app_error_widget.dart';
import 'package:nike/service_locator.dart';
import 'package:nike/features/feature_product/presentation/bloc/comment/comment_bloc.dart';
import 'package:nike/features/feature_product/presentation/widgets/comment_item.dart';

class CommentList extends StatelessWidget {
  final int productId;
  const CommentList({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = sl<CommentBloc>();
        bloc.add(LoadCommentEvent(productId: productId));
        return bloc;
      },
      child: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentCompleted) {
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return CommentItem(
                  comment: state.comments[index],
                );
              }, childCount: state.comments.length),
            );
          } else if (state is CommentError) {
            return SliverToBoxAdapter(
              child: AppErrorWidget(
                exception: AppException(),
                onTap: () => BlocProvider.of<CommentBloc>(context).add(
                  LoadCommentEvent(
                    productId: productId,
                  ),
                ),
              ),
            );
          } else if (state is CommentLoading) {
            return SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
