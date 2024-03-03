import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText, enableCounter;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? hintText;
  final void Function(String)? onChanged;

  final int? maxLength;
  const CustomTextField({
    super.key,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.hintText,
    this.onChanged,
    this.maxLength,
    this.enableCounter = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        counter: !enableCounter ? const SizedBox.shrink() : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
