import 'package:dio/dio.dart';
import 'package:nike/core/utils/constants.dart';

class CommentApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));

  Future<dynamic> getCommentsByProductId(int productId) async =>
      await dio.get('comment/list?product_id=$productId');
}
