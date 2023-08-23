import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<StatefulWidget> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _loginController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.grey,
                  BlendMode.modulate,
                ),
                image: AssetImage('lib/assets/images/todo_auth_back.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          child: Center(
            child: Container(
              height: 290,
              width: 240,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                // shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(width: 3, color: Colors.white),
              ),
              child: Column(
                children: [
                  const Text('Todo App', style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 8),
                    child: TextField(
                        controller: _loginController,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        style: const TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            label: const Text('Login', style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),),
                            contentPadding: const EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white, width: 2),),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white, width: 2),)
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                        controller: _passwordController,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        style: const TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                            label: const Text('Password', style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),),
                            contentPadding: const EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white, width: 2),),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white, width: 2),)
                        )
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: ElevatedButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(Login(
                                    login: _loginController.text,
                                    password: _passwordController.text));

                                if (_loginController.text == 'user0' && _passwordController.text == '123456') {
                                  Navigator.pushNamed(context, 'main/');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 42),
                                  backgroundColor: Colors.white
                              ),
                              child: const Text('Log In', style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Colors.black,
                              ),))
                      )
                ],
              ),
            )
        )
        )
    );
  }
}