import 'package:nike/core/params/auth_params.dart';
import 'package:nike/core/usecase/use_case.dart';
import 'package:nike/features/feature_auth/domain/repository/auth_repository.dart';

class RegisterUserUseCase extends UseCase<void, AuthParams> {
  final IAuthRepository _authRepository;

  RegisterUserUseCase(this._authRepository);
  @override
  Future<void> call(AuthParams params) async =>
      await _authRepository.register(params);
}
