import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nike/core/params/auth_params.dart';
import 'package:nike/core/utils/http_validator.dart';
import 'package:nike/features/auth/data/data_source/remote/auth_api_service.dart';
import 'package:nike/features/auth/data/models/auth_model.dart';

import 'package:nike/features/auth/domain/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository with HttpValidator implements IAuthRepository {
  final AuthApiService _authApiService;
  static final ValueNotifier<AuthModel?> authChangeNotifier = ValueNotifier(null);
  AuthRepository(this._authApiService);
  @override
  Future<AuthModel> login(AuthParams params) async {
    Response response = await _authApiService.login(params);
    validateResponse(response);

    final data = AuthModel.fromJson(response.data);
    final model = AuthModel(accessToken: data.accessToken, refreshToken: data.refreshToken, email: params.username);
    _setAuthToken(model);
    return model;
  }

  @override
  Future<AuthModel> register(AuthParams params) async {
    Response response = await _authApiService.register(params);
    validateResponse(response);
    return login(params);
  }

  @override
  Future<void> refreshToken() async {
    if (authChangeNotifier.value != null) {
      Response response = await _authApiService.refreshToken(authChangeNotifier.value!.refreshToken);
      validateResponse(response);
      final model = AuthModel.fromJson(response.data);
      debugPrint('refresh token is : ${model.refreshToken}');
      _setAuthToken(model);
    }
  }

  Future _setAuthToken(AuthModel authModel) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('access_token', authModel.accessToken);
    sharedPreferences.setString('refresh_token', authModel.refreshToken);
    sharedPreferences.setString('email', authModel.email);
    getAuthToken();
  }

  Future getAuthToken() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String accessToken = sharedPreferences.getString('access_token') ?? '';
    final String refreshToken = sharedPreferences.getString('refresh_token') ?? '';

    final String email = sharedPreferences.getString('email') ?? '';

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
        email: email,
      );
    }
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }

  static bool isUserLoggedIn() {
    return authChangeNotifier.value != null && authChangeNotifier.value!.accessToken.isNotEmpty;
  }
}
