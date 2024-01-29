import 'package:flutter/material.dart';
import 'package:fruit_market/features/onboarding/presentation/screens/widgets/onboarding_body.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return const OnBoardingBody();
  }
}
