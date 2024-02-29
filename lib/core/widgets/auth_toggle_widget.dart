import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';

class AuthToggleWidget extends StatelessWidget {
  final String text;
  final String buttonText;
  final void Function()? onTap;
  const AuthToggleWidget({
    super.key,
    required this.text,
    required this.buttonText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          overflow: TextOverflow.ellipsis,
        ),
        Flexible(
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              buttonText,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
