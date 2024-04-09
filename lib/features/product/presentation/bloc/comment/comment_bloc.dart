import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/core/params/insert_comment_params.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/auth/data/repository/auth_repository.dart';
import 'package:nike/features/product/domain/entities/comment_entity.dart';
import 'package:nike/features/product/domain/use_cases/get_comment_list_usecase.dart';
import 'package:nike/features/product/domain/use_cases/insert_comment_usecase.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetCommentListUsecase _getCommentListUsecase;
  final InsertCommentUseCase _insertCommentUseCase;
  CommentBloc(this._getCommentListUsecase, this._insertCommentUseCase) : super(CommentLoading()) {
    on<LoadCommentEvent>((event, emit) async {
      try {
        emit(CommentLoading());

        final comments = await _getCommentListUsecase(event.productId);
        emit(CommentCompleted(comments: comments));
      } catch (e) {
        emit(CommentError(message: e is AppException ? e.message : Constants.defaultErrorMessage));
      }
    });

    on<AddCommentEvent>(
      (event, emit) async {
        try {
          if (!AuthRepository.isUserLoggedIn()) {
            emit(InsertCommentError(AppException(message: 'لطفا وارد جساب کاربری خود شوید')));
          } else {
            if (event.content.isNotEmpty && event.title.isNotEmpty) {
              emit(InsertCommentLoading());
              final comment = await _insertCommentUseCase(
                InsertCommentParams(productId: event.productId, title: event.title, content: event.content),
              );
              emit(InsertCommentCompleted(comment));
            } else {
              emit(InsertCommentError(AppException(message: 'عنوان و متن خود را وارد کنید ')));
            }
          }
        } catch (e) {
          emit(InsertCommentError(AppException()));
        }
      },
    );
  }
}
