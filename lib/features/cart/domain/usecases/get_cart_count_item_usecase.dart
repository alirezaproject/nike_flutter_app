import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/cart/domain/repos/cart_repository.dart';

class GetCartCountItemUseCase extends UseCaseWithoutParams<int> {
  final ICartRepository _cartRepository;

  GetCartCountItemUseCase(this._cartRepository);

  @override
  Future<int> call() async => await _cartRepository.count();
}
