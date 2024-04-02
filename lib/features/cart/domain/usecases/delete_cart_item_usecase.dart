import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/cart/domain/repos/cart_repository.dart';

class DeleteCartItemUseCase extends UseCase<void, int> {
  final ICartRepository _cartRepository;

  DeleteCartItemUseCase(this._cartRepository);
  @override
  Future<void> call(int params) async {
    await _cartRepository.delete(params);
  }
}
