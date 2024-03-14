import 'package:nike/core/params/auth_params.dart';
import 'package:nike/features/feature_auth/data/models/auth_model.dart';

abstract class IAuthRepository {
  Future<AuthModel> login(AuthParams params);
  Future<AuthModel> register(AuthParams params);
  Future<AuthModel> refreshToken();

  Future getAuthToken();
}
