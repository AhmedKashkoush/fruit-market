import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/core/widgets/logos/social_logos.dart';

class CustomAuthButton extends StatelessWidget {
  final SocialAuthType authType;
  final void Function()? onPressed;
  final String label;
  final bool isLoading;
  const CustomAuthButton({
    super.key,
    required this.authType,
    this.onPressed,
    required this.label,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(12)),
        icon: _authLogoFromType(authType),
        label: !isLoading
            ? Text(label)
            : const FittedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    color: primary,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _authLogoFromType(SocialAuthType type) {
    if (isLoading) return const SizedBox.shrink();
    switch (type) {
      case SocialAuthType.google:
        return const GoogleLogo();
      case SocialAuthType.facebook:
        return const FacebookLogo();
      default:
        return const FlutterLogo();
    }
  }
}
