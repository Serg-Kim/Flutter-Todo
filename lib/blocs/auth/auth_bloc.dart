import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmkv/mmkv.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  var mmkv = MMKV('isAuth');

  AuthBloc() : super(AuthInitial(isAuth: MMKV('isAuth').decodeBool('isAuth'))) {
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<InitLogin>(_onInitLogin);
  }

  void _onInitLogin(InitLogin event, Emitter<AuthState> emit) {
    final isAuth = mmkv.decodeBool('isAuth');

    if (isAuth == true) {
      emit(const AuthInitial(isAuth: true));
    }
  }


  void _onLogin(Login event, Emitter<AuthState> emit) {
    final state = this.state;
    const String LOGIN = 'user0';
    const String PASSWORD = '123456';

    if (state is AuthInitial) {
      if (LOGIN == event.login && PASSWORD == event.password) {
        mmkv.encodeBool('isAuth', true);

        emit(const AuthInitial(isAuth: true));
      }
    }
  }


  void _onLogout(Logout event, Emitter<AuthState> emit) {
    final state = this.state;

    if (state is AuthInitial) {
        mmkv.encodeBool('isAuth', false);

        emit(const AuthInitial(isAuth: false));
    }
  }
}