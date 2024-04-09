import 'package:dio/dio.dart';
import 'package:nike/core/params/create_order_params.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/features/auth/data/repository/auth_repository.dart';

class OrderApiSerivce {
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

  Future<dynamic> create(CreateOrderParams params) async => await dio.post('/order/submit', data: {
        'first_name': params.firstName,
        'last_name': params.lastName,
        'postal_code': params.postalCode,
        'mobile': params.phoneNumber,
        'address': params.address,
        'payment_method': params.paymenyMethod == PaymentMethod.online ? 'online' : 'cash_on_delivery',
      });

  Future<dynamic> getPayment(int orderId) async => await dio.get('/order/checkout?order_id=$orderId');

  Future<dynamic> getOrders() async => await dio.get('/order/list');
}
