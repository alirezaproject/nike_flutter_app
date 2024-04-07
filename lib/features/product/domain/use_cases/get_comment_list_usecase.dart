import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/product/domain/entities/comment_entity.dart';
import 'package:nike/features/product/domain/repository/comment_repository.dart';

class GetCommentListUsecase extends UseCase<List<CommentEntity>, int> {
  final ICommentRepository _commentRepository;

  GetCommentListUsecase(this._commentRepository);
  @override
  Future<List<CommentEntity>> call(int params) async =>
      await _commentRepository.fetchComments(params);
}
