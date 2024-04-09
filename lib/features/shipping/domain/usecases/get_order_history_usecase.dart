import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/shipping/domain/entity/order_history_entity.dart';
import 'package:nike/features/shipping/domain/repos/order_repository.dart';

class GetOrderHistoryUseCase extends UseCaseWithoutParams<List<OrderHistoryEntity>> {
  final IOrderRepository _orderRepository;

  GetOrderHistoryUseCase(this._orderRepository);
  @override
  Future<List<OrderHistoryEntity>> call() async => _orderRepository.getOrders();
}
