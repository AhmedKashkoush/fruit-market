import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/lotties.dart';
import 'package:lottie/lottie.dart';

class OTPEnterWidget extends StatelessWidget {
  const OTPEnterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      otpLottie,
      height: 150,
    );
  }
}
