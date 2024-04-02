import 'package:nike/core/params/change_cart_count_params.dart';
import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/cart/domain/repos/cart_repository.dart';

class CartChangeCountUseCase extends UseCase<void, ChangeCartCountParams> {
  final ICartRepository _cartRepository;

  CartChangeCountUseCase(this._cartRepository);
  @override
  Future<void> call(ChangeCartCountParams params) async {
    await _cartRepository.changeCount(params.cartItemId, params.count);
  }
}
