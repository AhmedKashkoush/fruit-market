import 'package:flutter/material.dart';
import 'package:fruit_market/core/constants/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isLoading;
  final IconData? icon;
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? ElevatedButton.icon(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              // textStyle: const TextStyle(
              //   fontWeight: FontWeight.bold,
              //   fontSize: 8,
              // ),
              disabledBackgroundColor: primary.withOpacity(0.3),
              disabledForegroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 20,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            icon: !isLoading ? Icon(icon) : const SizedBox.shrink(),
            label: _displayWidget(),
          )
        : ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              disabledBackgroundColor: primary.withOpacity(0.3),
              disabledForegroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 10,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            child: _displayWidget(),
          );
  }

  Widget _displayWidget() {
    if (!isLoading) {
      return Text(text);
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
