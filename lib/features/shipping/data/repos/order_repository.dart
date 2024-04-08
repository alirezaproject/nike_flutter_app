import 'package:dio/dio.dart';
import 'package:nike/core/params/create_order_params.dart';
import 'package:nike/core/utils/http_validator.dart';
import 'package:nike/features/shipping/data/model/checkout_model.dart';
import 'package:nike/features/shipping/data/model/order_model.dart';
import 'package:nike/features/shipping/data/source/order_api_service.dart';
import 'package:nike/features/shipping/domain/entity/checkout_entity.dart';
import 'package:nike/features/shipping/domain/entity/order_entity.dart';
import 'package:nike/features/shipping/domain/repos/order_repository.dart';

class OrderRepository extends IOrderRepository with HttpValidator {
  final OrderApiSerivce _orderApiSerivce;

  OrderRepository(this._orderApiSerivce);
  @override
  Future<OrderEntity> create(CreateOrderParams params) async {
    Response response = await _orderApiSerivce.create(params);
    validateResponse(response);
    return OrderModel.fromJson(response.data);
  }

  @override
  Future<CheckoutEntity> get(int orderId) async {
    Response response = await _orderApiSerivce.getPayment(orderId);
    validateResponse(response);
    return CheckoutModel.fromJson(response.data);
  }
}
