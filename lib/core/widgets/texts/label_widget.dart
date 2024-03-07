import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  const LabelWidget({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
