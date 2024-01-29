import 'package:flutter/material.dart';
import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/core/constants/colors.dart';
import 'package:fruit_market/core/utils/app_navigator.dart';
import 'package:fruit_market/features/splash/presentation/screens/splash/widgets/splash_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat(reverse: true);
  late final Animation<double> _animation =
      Tween<double>(begin: 0.1, end: 1).animate(
    _controller,
  );

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      pushReplacementNamed(AppRoutes.onBoarding, context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: SplashBody(animation: _animation),
    );
  }
}
