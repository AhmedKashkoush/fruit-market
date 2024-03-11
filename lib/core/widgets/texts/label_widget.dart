import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final Color? color;
  final double? size;
  const LabelWidget({
    super.key,
    required this.label,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: color,
        fontSize: size,
      ),
    );
  }
}
