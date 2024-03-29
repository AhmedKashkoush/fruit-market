import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  final IconData? icon;
  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? OutlinedButton.icon(
            onPressed: onPressed,
            icon: !isLoading ? Icon(icon) : const SizedBox.shrink(),
            label: _displayWidget(),
          )
        : OutlinedButton(
            onPressed: onPressed,
            child: _displayWidget(),
          );
  }

  Widget _displayWidget() {
    if (!isLoading) {
      return Text(
        text,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      const double size = 20;
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
