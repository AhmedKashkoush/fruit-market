import 'package:flutter/material.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';
import 'package:gap/gap.dart';

class PasswordResetEmailLoadingWidget extends StatelessWidget {
  final String email;
  const PasswordResetEmailLoadingWidget({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator.adaptive(),
          const Gap(10),
          LabelWidget(label: 'Processing $email...'),
        ],
      ),
    );
  }
}
