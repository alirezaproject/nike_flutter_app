import 'package:dio/dio.dart';
import 'package:nike/core/params/auth_params.dart';
import 'package:nike/core/utils/constants.dart';

class AuthApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: Constants.baseApiUrl));

  Future<dynamic> login(AuthParams params) async => await dio.post('auth/token', data: {
        'grant_type': 'password',
        'client_id': 2,
        'client_secret': Constants.clientSecretKey,
        'username': params.username,
        'password': params.password
      });

  Future<dynamic> register(AuthParams params) async => await dio.post('user/register', data: {
        'email': params.username,
        'password': params.username,
      });

  Future<dynamic> refreshToken(String token) async => await dio.post('auth/token', data: {
        'grant_type': 'refresh_token',
        'refresh_token': token,
        'client_id': 2,
        'client_secret': Constants.clientSecretKey,
      });
}
