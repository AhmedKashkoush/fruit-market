import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/images.dart';

class BgWidget extends StatelessWidget {
  const BgWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      splashBg,
      fit: BoxFit.cover,
    );
  }
}
