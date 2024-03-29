import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  final IconData? icon;
  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? TextButton.icon(
            onPressed: onPressed,
            style: TextButton.styleFrom(foregroundColor: lightGrey),
            icon: !isLoading ? Icon(icon) : const SizedBox.shrink(),
            label: !isLoading
                ? Text(text)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          )
        : TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(foregroundColor: lightGrey),
            child: !isLoading
                ? Text(text)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
    );
  }
}
