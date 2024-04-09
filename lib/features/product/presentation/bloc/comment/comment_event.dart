part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class LoadCommentEvent extends CommentEvent {
  final int productId;

  const LoadCommentEvent({required this.productId});
}

class AddCommentEvent extends CommentEvent {
  final String title;
  final String content;
  final int productId;

  const AddCommentEvent({required this.title, required this.content, required this.productId});
}
