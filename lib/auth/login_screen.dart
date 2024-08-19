import 'package:flutter/material.dart';
import 'package:todo/auth/register_screen.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> keyState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: keyState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextFormField(
                controller: emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.trim().length < 5) {
                    return 'Email cannot be less than 5 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              DefaultTextFormField(
                controller: passwordController,
                isPassword: true,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 8) {
                    return 'Password cannot be less than 8 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 32,
              ),
              DefaultElevatedButton(
                label: 'Login',
                onPressed: login,
              ),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    RegisterScreen.routeName,
                  );
                },
                child: const Text(
                  'Don\'t have an account?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (keyState.currentState!.validate()) {}
  }
}
