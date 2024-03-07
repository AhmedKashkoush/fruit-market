import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SocialDividerWidget extends StatelessWidget {
  const SocialDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 2,
          ),
        ),
        Gap(2),
        Text('Or'),
        Gap(2),
        Expanded(
          child: Divider(
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
