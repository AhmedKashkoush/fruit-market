import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  final IconData? icon;
  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? OutlinedButton.icon(
            onPressed: onPressed,
            icon: !isLoading ? Icon(icon) : const SizedBox.shrink(),
            label: !isLoading
                ? Text(text)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          )
        : OutlinedButton(
            onPressed: onPressed,
            child: !isLoading
                ? Text(text)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
  }
}
