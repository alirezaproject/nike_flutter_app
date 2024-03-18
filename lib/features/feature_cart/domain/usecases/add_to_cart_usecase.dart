import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/feature_cart/domain/entities/cart_response_entity.dart';
import 'package:nike/features/feature_cart/domain/repos/cart_repository.dart';

class AddToCartUseCase extends UseCase<CartResponseEntity, int> {
  final ICartRepository _cartRepository;

  AddToCartUseCase(this._cartRepository);
  @override
  Future<CartResponseEntity> call(int params) async => await _cartRepository.add(params);
}
