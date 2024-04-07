import 'package:nike/core/params/create_order_params.dart';
import 'package:nike/features/shipping/domain/entity/order_entity.dart';

abstract class IOrderRepository {
  Future<OrderEntity> create(CreateOrderParams params);
}
