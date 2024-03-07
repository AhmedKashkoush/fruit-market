import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: lightGrey),
      child: Text(
        text,
      ),
    );
  }
}
