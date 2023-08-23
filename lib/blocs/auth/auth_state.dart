part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  final bool isAuth;

  const AuthInitial({required this.isAuth});

  @override
  List<Object> get props => [isAuth];
}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String error;
  const AuthError({required this.error});

  @override
  List<Object> get props => [error];
}