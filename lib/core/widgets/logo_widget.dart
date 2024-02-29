import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/images.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      logo,
      height: 200,
    );
  }
}
