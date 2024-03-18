import 'package:dio/dio.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/features/feature_auth/data/repository/auth_repository.dart';

class CartApiService {
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

  Future<dynamic> add(int productId) async => await dio.post(
        'cart/add',
        data: {
          "product_id": productId,
        },
      );

  // Future<dynamic> changeCount(int cartItemId, int count) {}
  // Future<dynamic> delete(int cartItemId) {}
  // Future<dynamic> count() {}
  // Future<dynamic> list() {}
}
