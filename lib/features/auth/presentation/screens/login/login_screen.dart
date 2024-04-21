import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/config/routes/extras.dart';
import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/core/utils/app_navigator.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/core/utils/parameters.dart';
import 'package:fruit_market/core/utils/snack_messages.dart';
import 'package:fruit_market/core/widgets/layout/orientation_widget.dart';
import 'package:fruit_market/features/auth/presentation/screens/login/bloc/login_bloc.dart';
import 'package:fruit_market/features/auth/presentation/screens/login/bloc/login_events.dart';
import 'package:fruit_market/features/auth/presentation/screens/login/widgets/login_screen_landscape.dart';
import 'package:fruit_market/features/auth/presentation/screens/login/widgets/login_screen_portrait.dart';

import 'bloc/login_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _isPasswordShown = ValueNotifier<bool>(false);
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showErrorSnackBar(
              context,
              state.message,
              errorType: state.errorType,
              onActionTap: state.errorType == ErrorType.verification
                  ? () => _sendEmailVerification(context)
                  : null,
            );
          }

          if (state is LoginSuccessState) {
            showSuccessSnackBar(
              context,
              'You logged in successfully',
              successType: SuccessType.auth,
            );
            goNamed(AppRoutes.home, context);
          }

          if (state is EmailVerificationError) {
            showErrorSnackBar(
              context,
              state.message,
              errorType: state.errorType,
              actionLabel: 'Retry',
              onActionTap: () => _sendEmailVerification(context),
            );
          }

          if (state is EmailVerificationSuccess) {
            showSuccessSnackBar(
              context,
              'Email verification sent to ${state.email}',
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: OrientationWidget(
              portrait: LoginScreenPortrait(
                isPasswordShown: _isPasswordShown,
                isLoading: state is LoginLoadingState,
                isGoogleLoading: state is GoogleLoginLoadingState,
                isFacebookLoading: state is FacebookLoginLoadingState,
                emailOrPhoneController: _emailOrPhoneController,
                passwordController: _passwordController,
                login: _login,
                loginWithGoogle: _loginWithGoogle,
                loginWithFacebook: _loginWithFacebook,
                togglePasswordInvisibility: _togglePasswordInvisibility,
                goToSignUp: _goToSignUp,
                goToChooseVerifyMethod: _goToChooseVerifyMethod,
              ),
              landscape: LoginScreenLandscape(
                isPasswordShown: _isPasswordShown,
                isLoading: state is LoginLoadingState,
                isGoogleLoading: state is GoogleLoginLoadingState,
                isFacebookLoading: state is FacebookLoginLoadingState,
                emailOrPhoneController: _emailOrPhoneController,
                passwordController: _passwordController,
                login: _login,
                loginWithGoogle: _loginWithGoogle,
                loginWithFacebook: _loginWithFacebook,
                togglePasswordInvisibility: _togglePasswordInvisibility,
                goToSignUp: _goToSignUp,
                goToChooseVerifyMethod: _goToChooseVerifyMethod,
              ),
            ),
          );
        },
      ),
    );
  }

  void _login(BuildContext context) {
    FocusScope.of(context).unfocus();
    final LoginParams params = LoginParams(
      email: _emailOrPhoneController.text.trim(),
      password: _passwordController.text.trim(),
    );
    context.read<LoginBloc>().add(
          LoginWithEmailAndPasswordEvent(params),
        );
  }

  void _loginWithGoogle(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<LoginBloc>().add(
          LoginWithGoogleEvent(),
        );
  }

  void _loginWithFacebook(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<LoginBloc>().add(
          LoginWithFacebookEvent(),
        );
  }

  void _togglePasswordInvisibility() {
    _isPasswordShown.value = !_isPasswordShown.value;
  }

  void _goToChooseVerifyMethod(BuildContext context) {
    final Map<String, String> extras = {
      Extras.emailRoute: AppRoutes.emailInput,
      Extras.phoneRoute: AppRoutes.phoneInput,
    };
    pushNamed(
      AppRoutes.chooseVerificationMethod,
      context,
      extra: extras,
    );
  }

  void _goToSignUp(BuildContext context) {
    FocusScope.of(context).unfocus();
    pushReplacementNamed(AppRoutes.signUp, context);
  }
  
  void _sendEmailVerification(BuildContext context) {
    context.read<LoginBloc>().add(
          SendEmailVerificationEvent(
            LoginParams(
              email: _emailOrPhoneController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          ),
        );
  }
}
