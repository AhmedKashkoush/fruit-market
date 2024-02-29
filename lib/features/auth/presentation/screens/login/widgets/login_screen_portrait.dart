import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/core/widgets/auth_toggle_widget.dart';
import 'package:fruit_market/core/widgets/custom_auth_button.dart';
import 'package:fruit_market/core/widgets/custom_elevated_button.dart';
import 'package:fruit_market/core/widgets/custom_text_field.dart';
import 'package:fruit_market/core/widgets/label_widget.dart';
import 'package:fruit_market/core/widgets/logo_widget.dart';
import 'package:fruit_market/core/widgets/social_divider_widget.dart';
import 'package:fruit_market/core/widgets/title_widget.dart';
import 'package:gap/gap.dart';

class LoginScreenPortrait extends StatelessWidget {
  final ValueNotifier<bool> isPasswordShown;
  final bool isLoading, isGoogleLoading, isFacebookLoading;
  final TextEditingController emailOrPhoneController, passwordController;
  final void Function(BuildContext) login,
      loginWithGoogle,
      loginWithFacebook,
      goToSignUp;
  final void Function() togglePasswordInvisibility;
  const LoginScreenPortrait({
    super.key,
    required this.isPasswordShown,
    required this.isLoading,
    required this.isGoogleLoading,
    required this.isFacebookLoading,
    required this.emailOrPhoneController,
    required this.passwordController,
    required this.login,
    required this.loginWithGoogle,
    required this.loginWithFacebook,
    required this.togglePasswordInvisibility,
    required this.goToSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      reverse: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const LogoWidget(),
          const Gap(5),
          const TitleWidget(
            color: primary,
          ),
          const LabelWidget(label: 'Email Or Phone'),
          const Gap(2),
          CustomTextField(
            controller: emailOrPhoneController,
            keyboardType: TextInputType.text,
          ),
          const Gap(5),
          const LabelWidget(
            label: 'Password',
          ),
          const Gap(2),
          ValueListenableBuilder(
              valueListenable: isPasswordShown,
              builder: (context, value, _) {
                return CustomTextField(
                  controller: passwordController,
                  obscureText: !value,
                  keyboardType: TextInputType.text,
                  suffixIcon: IconButton(
                    onPressed: togglePasswordInvisibility,
                    icon: value
                        ? const Icon(CupertinoIcons.eye_slash_fill)
                        : const Icon(CupertinoIcons.eye_fill),
                  ),
                );
              }),
          const Gap(15),
          CustomElevatedButton(
            text: 'Log in',
            isLoading: isLoading,
            onPressed: isLoading || isGoogleLoading || isFacebookLoading
                ? null
                : () {
                    login(context);
                  },
          ),
          const Gap(15),
          const SocialDividerWidget(),
          const Gap(15),
          Row(
            children: [
              Expanded(
                child: CustomAuthButton(
                  label: 'Log in with',
                  authType: SocialAuthType.google,
                  isLoading: isGoogleLoading,
                  onPressed: isLoading || isGoogleLoading || isFacebookLoading
                      ? null
                      : () {
                          loginWithGoogle(context);
                        },
                ),
              ),
              const Gap(10),
              Expanded(
                child: CustomAuthButton(
                  label: 'Log in with',
                  authType: SocialAuthType.facebook,
                  isLoading: isFacebookLoading,
                  onPressed: isLoading || isGoogleLoading || isFacebookLoading
                      ? null
                      : () {
                          loginWithFacebook(context);
                        },
                ),
              ),
            ],
          ),
          const Gap(10),
          AuthToggleWidget(
            text: 'If you don\'t have an account you can ',
            buttonText: 'Sign up',
            onTap: isLoading || isGoogleLoading || isFacebookLoading
                ? null
                : () {
                    goToSignUp(context);
                  },
          ),
        ],
      ),
    );
  }
}
