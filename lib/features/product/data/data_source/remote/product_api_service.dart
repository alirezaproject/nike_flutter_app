import 'package:dio/dio.dart';
import 'package:nike/core/utils/constants.dart';

class ProductApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));

  Future<dynamic> getProductList(int sort) async =>
      await dio.get('product/list?sort=$sort');

  Future<dynamic> searchProduct(String search) async =>
      await dio.get('product/search?q=$search');
}
