import 'package:dio/dio.dart';
import 'package:nike/core/utils/constants.dart';

class BannerApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));

  Future<dynamic> callBannerList() async => await dio.get('banner/slider');
}
