import 'package:nike/core/params/insert_comment_params.dart';
import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/product/domain/entities/comment_entity.dart';
import 'package:nike/features/product/domain/repository/comment_repository.dart';

class InsertCommentUseCase extends UseCase<CommentEntity, InsertCommentParams> {
  final ICommentRepository _commentRepository;

  InsertCommentUseCase(this._commentRepository);
  @override
  Future<CommentEntity> call(InsertCommentParams params) async => await _commentRepository.insert(params);
}
