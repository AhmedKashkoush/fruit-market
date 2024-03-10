import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';

class PasswordResetEmailErrorWidget extends StatelessWidget {
  final String email;
  final void Function()? onRetry;

  const PasswordResetEmailErrorWidget({
    super.key,
    required this.email,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LabelWidget(label: 'Error sending email to $email'),
          IconButton.filled(
            onPressed: onRetry,
            icon: const Icon(CupertinoIcons.refresh_circled),
          ),
        ],
      ),
    );
  }
}
