import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 20,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
