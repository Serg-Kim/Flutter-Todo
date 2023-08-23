part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class InitLogin extends AuthEvent {
  const InitLogin();

  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  final String login;
  final String password;

  const Login({required this.login, required this.password});

  @override
  List<Object> get props => [login, password];
}

class Logout extends AuthEvent {
  const Logout();

  @override
  List<Object> get props => [];
}