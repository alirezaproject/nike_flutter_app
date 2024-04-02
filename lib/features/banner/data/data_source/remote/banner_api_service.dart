import 'package:dio/dio.dart';
import 'package:nike/core/utils/constants.dart';

class BannerApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));

  Future<dynamic> getBannersList() async => await dio.get('banner/slider');
}
