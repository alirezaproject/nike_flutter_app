import 'package:dio/dio.dart';
import 'package:nike/core/utils/constants.dart';

class ProductApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));
}
