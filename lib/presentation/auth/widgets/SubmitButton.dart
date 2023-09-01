import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {super.key, required this.formKey, required this.loginController, required this.passwordController});

  final GlobalKey<FormState> formKey;
  final TextEditingController loginController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<AuthBloc>()
                    .add(
                    Login(
                        login: loginController.text,
                        password: passwordController.text
                    ));
                if (loginController.text ==
                    'user0' &&
                    passwordController.text ==
                        '123456') {
                  Navigator.pushReplacementNamed(
                      context, 'main/');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Color.fromRGBO(25, 25, 25, 0.6),
                          content: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Text(
                                        'Incorrect login or password, try again.',
                                        style: TextStyle(
                                            fontFamily: 'Quicksand'))
                                )
                              ],),
                          )
                      );
                }
              }
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets
                    .symmetric(
                    horizontal: 42),
                backgroundColor: Colors
                    .white
            ),
            child: const Text(
              'Log In', style: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.black,
            ),))
    );
  }
}