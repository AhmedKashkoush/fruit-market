import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/texts.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      appName,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 42,
      ),
    );
  }
}
