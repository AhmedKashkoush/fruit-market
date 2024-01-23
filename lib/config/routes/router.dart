import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:fruit_market/features/splash/presentation/screens/splash_screen.dart';
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
  ],
);
