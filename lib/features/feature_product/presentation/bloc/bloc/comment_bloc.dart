import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/feature_product/domain/entities/comment_entity.dart';
import 'package:nike/features/feature_product/domain/use_cases/get_comment_list_usecase.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetCommentListUsecase _getCommentListUsecase;
  CommentBloc(this._getCommentListUsecase) : super(CommentStarted()) {
    on<CommentEvent>((event, emit) async {
      if (event is LoadCommentEvent) {
        try {
          emit(CommentLoading());

          final comments = await _getCommentListUsecase(event.productId);
          emit(CommentCompleted(comments: comments));
        } catch (e) {
          emit(CommentError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
