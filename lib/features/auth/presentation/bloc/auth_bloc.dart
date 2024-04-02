import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nike/core/params/auth_params.dart';
import 'package:nike/core/utils/error_handler.dart';
import 'package:nike/features/auth/domain/usecases/login_user_usecase.dart';
import 'package:nike/features/auth/domain/usecases/register_user_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isLoginMode;
  final LoginUserUseCase _loginUserUseCase;
  final RegisterUserUseCase _registerUserUseCase;
  AuthBloc(this.isLoginMode, this._loginUserUseCase, this._registerUserUseCase) : super(AuthInitial(isLoginMode)) {
    on<LoadAuthScreen>((event, emit) async {
      emit(AuthInitial(isLoginMode));
    });
    on<ClickAuthbuttonEvent>((event, emit) async {
      try {
        emit(AuthLoading(isLoginMode));
        if (isLoginMode) {
          await _loginUserUseCase(event.params);
          emit(AuthSuccess(isLoginMode));
        } else {
          await _registerUserUseCase(event.params);

          emit(AuthSuccess(isLoginMode));
        }
      } catch (e) {
        emit(AuthError(isLoginMode, AppException()));
      }
    });
    on<ClickAuthModeChangeEvent>((event, emit) async {
      isLoginMode = !isLoginMode;
      emit(AuthInitial(isLoginMode));
    });
  }
}
