import 'package:dio/dio.dart';
import 'package:nike/core/params/insert_comment_params.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/features/auth/data/repository/auth_repository.dart';

class CommentApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl))
    ..interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        final authInfo = AuthRepository.authChangeNotifier.value;
        if (authInfo != null && authInfo.accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer ${authInfo.accessToken}';
        }
        handler.next(options);
      }),
    );

  Future<dynamic> getCommentsByProductId(int productId) async => await dio.get('comment/list?product_id=$productId');

  Future<dynamic> addComment(InsertCommentParams params) async => await dio.post('comment/add', data: {
        "title": params.title,
        "content": params.content,
        "product_id": params.productId,
      });
}
