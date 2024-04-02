part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentLoading extends CommentState {}

class CommentError extends CommentState {
  final String message;

  const CommentError({required this.message});

  @override
  List<Object> get props => [message];
}

class CommentCompleted extends CommentState {
  final List<CommentEntity> comments;

  const CommentCompleted({required this.comments});

  @override
  List<Object> get props => [comments];
}
