import 'package:nike/core/params/create_order_params.dart';
import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/shipping/domain/entity/order_entity.dart';
import 'package:nike/features/shipping/domain/repos/order_repository.dart';

class CreateOrderUseCase extends UseCase<OrderEntity, CreateOrderParams> {
  final IOrderRepository _orderRepository;

  CreateOrderUseCase(this._orderRepository);
  @override
  Future<OrderEntity> call(CreateOrderParams params) async =>
      await _orderRepository.create(params);
}
