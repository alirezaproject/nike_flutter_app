import 'package:nike/features/product/domain/entities/comment_entity.dart';

abstract class ICommentRepository {
  Future<List<CommentEntity>> fetchComments(int productId);
}
