import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/core/constants/colors.dart';
import 'package:fruit_market/core/constants/preferences_keys.dart';
import 'package:fruit_market/core/helpers/shared_preferences_helper.dart';
import 'package:fruit_market/core/utils/app_navigator.dart';
import 'package:fruit_market/core/utils/locator.dart';
import 'package:fruit_market/features/splash/presentation/screens/splash/widgets/splash_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final SharedPreferecesHelper _helper = SharedPreferecesHelper();
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
      final FirebaseAuth auth = sl<FirebaseAuth>();
      if (auth.currentUser != null) {
        goNamed(AppRoutes.home, context);
      } else {
        _goToRoute().then(
        (route) => pushReplacementNamed(route, context),
      );
      }
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

  Future<String> _goToRoute() async {
    bool shownOnBoarding =
        (_helper.read<bool>(PreferencesKeys.shownOnboarding) as bool?) ?? false;
    if (!shownOnBoarding) return AppRoutes.onBoarding;
    return AppRoutes.login;
  }
}
