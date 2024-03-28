import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/feature_cart/domain/entities/cart_entity.dart';
import 'package:nike/features/feature_cart/domain/repos/cart_repository.dart';

class GetCartListUseCase extends UseCaseWithoutParams<CartEntity> {
  final ICartRepository _cartRepository;

  GetCartListUseCase(this._cartRepository);
  @override
  Future<CartEntity> call() async => await _cartRepository.list();
}
