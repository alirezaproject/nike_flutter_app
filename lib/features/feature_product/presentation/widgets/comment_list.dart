import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/core/widgets/app_error_widget.dart';
import 'package:nike/di.dart';
import 'package:nike/features/feature_product/presentation/bloc/bloc/comment_bloc.dart';
import 'package:nike/features/feature_product/presentation/widgets/comment_item.dart';

class CommentList extends StatelessWidget {
  final int productId;
  const CommentList({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = di<CommentBloc>();
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
          } else if (state is CommentLoading) {
            return SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CommentError) {
            return SliverToBoxAdapter(
              child: AppErrorWidget(
                exception: state.exception,
                onTap: () => BlocProvider.of<CommentBloc>(context).add(
                  LoadCommentEvent(
                    productId: productId,
                  ),
                ),
              ),
            );
          }
          return SliverToBoxAdapter(child: Container());
        },
      ),
    );
  }
}
