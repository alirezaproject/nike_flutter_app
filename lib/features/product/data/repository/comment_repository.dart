import 'package:dio/dio.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/core/utils/http_validator.dart';
import 'package:nike/features/product/data/data_source/remote/comment_api_service.dart';
import 'package:nike/features/product/data/model/comment_model/comment_model.dart';
import 'package:nike/features/product/domain/entities/comment_entity.dart';
import 'package:nike/features/product/domain/repository/comment_repository.dart';

class CommentRepository with HttpValidator implements ICommentRepository {
  final CommentApiService _commentApiService;

  CommentRepository(this._commentApiService);
  @override
  Future<List<CommentEntity>> fetchComments(int productId) async {
    try {
      Response response = await _commentApiService.getCommentsByProductId(productId);
      validateResponse(response);

      List<CommentEntity> comments = (response.data as List).map((json) => CommentModel.fromJson(json)).map((e) {
        return CommentEntity(
          id: e.id,
          title: e.title,
          content: e.content,
          date: e.date,
          author: e.author,
        );
      }).toList();
      return comments;
    } catch (e) {
      throw AppException();
    }
  }
}
