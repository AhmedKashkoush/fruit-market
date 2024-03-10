import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final IconData? icon;
  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? TextButton.icon(
            onPressed: onPressed,
            style: TextButton.styleFrom(foregroundColor: lightGrey),
            icon: Icon(icon),
            label: Text(
              text,
            ),
          )
        : TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: lightGrey),
      child: Text(
        text,
      ),
    );
  }
}
