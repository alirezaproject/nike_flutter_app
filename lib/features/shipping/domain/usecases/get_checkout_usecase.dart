import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/shipping/domain/entity/checkout_entity.dart';
import 'package:nike/features/shipping/domain/repos/order_repository.dart';

class GetCheckoutUseCase extends UseCase<CheckoutEntity, int> {
  final IOrderRepository _orderRepository;

  GetCheckoutUseCase(this._orderRepository);
  @override
  Future<CheckoutEntity> call(int params) async =>
      await _orderRepository.get(params);
}
