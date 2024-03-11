import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fruit_market/config/routes/path_parameters.dart';
import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/core/utils/locator.dart';
import 'package:fruit_market/features/auth/presentation/screens/choose%20location%20manually/choose_location_manually_screen.dart';
import 'package:fruit_market/features/auth/presentation/screens/choose%20verification%20method/choose_verification_method_screen.dart';
import 'package:fruit_market/features/auth/presentation/screens/forgot%20password/email%20input/email_input_screen.dart';
import 'package:fruit_market/features/auth/presentation/screens/forgot%20password/phone%20input/phone_input_screen.dart';
import 'package:fruit_market/features/auth/presentation/screens/login/login_screen.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/signup_screen.dart';
import 'package:fruit_market/features/auth/presentation/screens/verification/email/password_reset_email_screen.dart';
import 'package:fruit_market/features/auth/presentation/screens/verification/phone/phone_verification_screen.dart';
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
      name: AppRoutes.chooseVerificationMethod,
      path:
          '${AppRoutes.chooseVerificationMethod}/:${PathParameters.emailRoute}/:${PathParameters.phoneRoute}',
      builder: (context, state) => ChooseVerificationMethodScreen(
        emailRoute: state.pathParameters[PathParameters.emailRoute]!,
        phoneRoute: state.pathParameters[PathParameters.phoneRoute]!,
      ),
    ),
    GoRoute(
      name: AppRoutes.emailInput,
      path: AppRoutes.emailInput,
      builder: (context, state) => const EmailInputScreen(),
    ),
    GoRoute(
      name: AppRoutes.phoneInput,
      path: AppRoutes.phoneInput,
      builder: (context, state) => const PhoneInputScreen(),
    ),
    GoRoute(
      name: AppRoutes.emailVerification,
      path: '${AppRoutes.emailVerification}/:${PathParameters.email}',
      builder: (context, state) => PasswordResetEmailScreen(
        email: state.pathParameters[PathParameters.email]!,
      ),
    ),
    GoRoute(
      name: AppRoutes.phoneVerification,
      path: AppRoutes.phoneVerification,
      builder: (context, state) => const PhoneVerificationScreen(),
    ),
    GoRoute(
      name: AppRoutes.chooseLocation,
      path: AppRoutes.chooseLocation,
      builder: (context, state) => ChooseLocationManuallyScreen(
        connectivity: sl<Connectivity>(),
      ),
    ),
  ],
);
