import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    super.key,
    required this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Text(
        'Forgot Password?',
        textAlign: TextAlign.end,
        style: TextStyle(
          color: primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
