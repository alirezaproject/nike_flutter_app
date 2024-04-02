import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/auth/domain/repository/auth_repository.dart';

class SignOutUserUseCase extends UseCaseWithoutParams<void> {
  final IAuthRepository _authRepository;

  SignOutUserUseCase(this._authRepository);

  @override
  Future<void> call() async {
    await _authRepository.signOut();
  }

  Future<void> refreshToken() async {
    await _authRepository.refreshToken();
  }
}
