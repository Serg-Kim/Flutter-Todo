import 'package:flutter/material.dart';
import 'package:flutter_todo/presentation/auth/widgets/AuthForm.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.grey,
                BlendMode.modulate,
              ),
              image: AssetImage(
                  'lib/assets/images/todo_auth_back.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                  child:
                  ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery
                            .of(context)
                            .size
                            .width,
                        minHeight: MediaQuery
                            .of(context)
                            .size
                            .height,
                      ),
                      child: const AuthForm(),
                  )
              )
          )
      );
  }
}