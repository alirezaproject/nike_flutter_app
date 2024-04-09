import 'package:nike/core/params/create_order_params.dart';
import 'package:nike/features/shipping/domain/entity/checkout_entity.dart';
import 'package:nike/features/shipping/domain/entity/order_entity.dart';
import 'package:nike/features/shipping/domain/entity/order_history_entity.dart';

abstract class IOrderRepository {
  Future<OrderEntity> create(CreateOrderParams params);
  Future<CheckoutEntity> get(int orderId);
  Future<List<OrderHistoryEntity>> getOrders();
}
