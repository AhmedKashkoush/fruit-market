import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/features/auth/presentation/screens/login/login_screen.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/signup_screen.dart';
import 'package:fruit_market/features/auth/presentation/screens/verification/verification_screen.dart';
import 'package:fruit_market/features/onboarding/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:fruit_market/features/splash/presentation/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      name: AppRoutes.splash,
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: AppRoutes.onBoarding,
      path: AppRoutes.onBoarding,
      builder: (context, state) => const OnBoardingScreen(),
    ),
    GoRoute(
      name: AppRoutes.login,
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: AppRoutes.signUp,
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: AppRoutes.verification,
      path: AppRoutes.verification,
      builder: (context, state) => const VerificationScreen(),
    ),
  ],
);
