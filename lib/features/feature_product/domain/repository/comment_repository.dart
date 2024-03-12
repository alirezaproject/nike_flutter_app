import 'package:nike/features/feature_product/domain/entities/comment_entity.dart';

abstract class ICommentRepository {
  Future<List<CommentEntity>> fetchComments(int productId);
}
