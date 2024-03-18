part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final bool isLoginMode;

  const AuthState(this.isLoginMode);

  @override
  List<Object> get props => [isLoginMode];
}

class AuthInitial extends AuthState {
  const AuthInitial(super.isLoginMode);

  @override
  List<Object> get props => [isLoginMode];
}

class AuthLoading extends AuthState {
  const AuthLoading(super.isLoginMode);

  @override
  List<Object> get props => [isLoginMode];
}

class AuthError extends AuthState {
  final AppException exception;
  const AuthError(super.isLoginMode, this.exception);

  @override
  List<Object> get props => [isLoginMode];
}

class AuthSuccess extends AuthState {
  const AuthSuccess(super.isLoginMode);

  @override
  List<Object> get props => [isLoginMode];
}
