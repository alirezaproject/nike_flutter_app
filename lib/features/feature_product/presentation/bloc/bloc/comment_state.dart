part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentStarted extends CommentState {}

class CommentLoading extends CommentState {}

class CommentError extends CommentState {
  final AppException exception;

  const CommentError({required this.exception});

  @override
  List<Object> get props => [exception];
}

class CommentCompleted extends CommentState {
  final List<CommentEntity> comments;

  const CommentCompleted({required this.comments});

  @override
  List<Object> get props => [comments];
}
