import 'package:flutter/material.dart';

class ResendButton extends StatelessWidget {
  final void Function() onResend;
  const ResendButton({
    super.key,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onResend,
      child: const Text('Resend code'),
    );
  }
}
