import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText, enableCounter, readOnly;
  final bool? enableInteractiveSelection;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;

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
    this.validator,
    this.inputFormatters,
    this.enableInteractiveSelection,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
      maxLength: maxLength,
      validator: validator,
      inputFormatters: inputFormatters,
      enableInteractiveSelection: enableInteractiveSelection,
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
