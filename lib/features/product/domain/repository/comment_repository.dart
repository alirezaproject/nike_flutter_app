import 'package:nike/core/params/insert_comment_params.dart';
import 'package:nike/features/product/domain/entities/comment_entity.dart';

abstract class ICommentRepository {
  Future<List<CommentEntity>> fetchComments(int productId);

  Future<CommentEntity> insert(InsertCommentParams params);
}
