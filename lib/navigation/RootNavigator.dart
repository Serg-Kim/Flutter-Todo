import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/navigation/MainNavigator.dart';
import 'package:flutter_todo/presentation/auth/screens/AuthScreen.dart';

import '../blocs/auth/auth_bloc.dart';

class RootNavigator extends StatelessWidget {
  const RootNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    String initialRoute = 'auth/';

    return BlocProvider<AuthBloc>(
        create: (context) =>
        AuthBloc()
          ..add(const InitLogin()),
        lazy: false,
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthInitial) {
            if (state.isAuth == true) initialRoute = 'main/';
          }

            return Navigator(
                initialRoute: initialRoute,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case 'auth/':
                      builder =
                          (BuildContext context) => const AuthScreen();
                    case 'main/':
                      builder =
                          (BuildContext context) => const MainNavigator();
                    default:
                      throw Exception('Invalid route: ${settings.name}');
                  }
                  return MaterialPageRoute<void>(
                      builder: builder, settings: settings
                  );
                }
            );
        })
    );
  }
}