import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/texts.dart';

class TitleWidget extends StatelessWidget {
  final Color color;
  const TitleWidget({
    super.key,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      appName,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 42,
      ),
    );
  }
}
