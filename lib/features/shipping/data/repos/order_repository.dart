import 'package:dio/dio.dart';
import 'package:nike/core/params/create_order_params.dart';
import 'package:nike/core/utils/http_validator.dart';
import 'package:nike/features/shipping/data/model/checkout_model.dart';
import 'package:nike/features/shipping/data/model/order_history_model/order_history_model.dart';
import 'package:nike/features/shipping/data/model/order_model.dart';
import 'package:nike/features/shipping/data/source/order_api_service.dart';
import 'package:nike/features/shipping/domain/entity/checkout_entity.dart';
import 'package:nike/features/shipping/domain/entity/order_entity.dart';
import 'package:nike/features/shipping/domain/entity/order_history_entity.dart';
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

  @override
  Future<List<OrderHistoryEntity>> getOrders() async {
    Response response = await _orderApiSerivce.getOrders();
    validateResponse(response);

    List<OrderHistoryEntity> orders = (response.data as List)
        .map((json) => OrderHistoryModel.fromJson(json))
        .map((e) => OrderHistoryEntity(
            id: e.id,
            firstName: e.firstName,
            lastName: e.lastName,
            postalCode: e.postalCode,
            phone: e.phone,
            address: e.address,
            payable: e.payable,
            total: e.total,
            shippingCost: e.shippingCost,
            paymentStatus: e.paymentStatus,
            paymentMethod: e.paymentMethod,
            userId: e.userId,
            date: e.date,
            orderItems: e.orderItems))
        .toList();

    return orders;
  }
}
