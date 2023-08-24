import 'package:flutter/material.dart';
import 'package:flutter_todo/presentation/auth/widgets/FormInput.dart';
import 'SubmitButton.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});


  @override
  State<StatefulWidget> createState() => _AuthFormState();
}

class _AuthFormState extends State<StatefulWidget> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

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
    return Center(
        child: Container(
          // height: 360,
            width: 240,
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              // shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                  width: 3, color: Colors.white),
            ),
            child:
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(padding: EdgeInsets.only(bottom: 24),
                  child: Text('Todo App', style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )),
                  ),
                  FormInput(label: 'Login', error: 'Please enter login', controller: _loginController),
                  FormInput(label: 'Password', error: 'Password should contains at least 6 characters', controller: _passwordController),
                  SubmitButton(formKey: _formKey, loginController: _loginController, passwordController: _passwordController)
                ],
              ),
            )));
  }
}