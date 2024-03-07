import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          disabledBackgroundColor: primary.withOpacity(0.3),
          disabledForegroundColor: Colors.white,
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
        child: !isLoading
            ? Text(text)
            : const FittedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    color: primary,
                  ),
                ),
              ),
      ),
    );
  }
}
