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
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(12)),
      icon: _authLogoFromType(authType),
      label: _displayWidget(),
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
  
  Widget _displayWidget() {
    if (!isLoading) {
      return Text(
        label,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      const double size = 28;
      return const Center(
        child: SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(
            color: primary,
          ),
        ),
      );
    }
  }
}
