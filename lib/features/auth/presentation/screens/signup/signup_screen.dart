import 'package:flutter/material.dart';
import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/core/utils/app_navigator.dart';
import 'package:fruit_market/core/widgets/auth_toggle_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('SignUp'),
          AuthToggleWidget(
            text: 'If you already have an account you can ',
            buttonText: 'Log in',
            onTap: () {
              _goToLogin(context);
            },
          ),
        ],
      ),
    );
  }
  
  void _goToLogin(BuildContext context) {
    pushReplacementNamed(AppRoutes.login, context);
  }
}
