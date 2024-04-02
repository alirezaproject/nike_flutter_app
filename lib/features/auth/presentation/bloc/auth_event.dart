part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoadAuthScreen extends AuthEvent {}

class ClickAuthbuttonEvent extends AuthEvent {
  final AuthParams params;

  const ClickAuthbuttonEvent({required this.params});
}

class ClickAuthModeChangeEvent extends AuthEvent {}
