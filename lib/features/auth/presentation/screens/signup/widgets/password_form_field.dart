import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/core/extensions/string_validations.dart';
import 'package:fruit_market/core/widgets/buttons/toggle_invisibility_button.dart';
import 'package:fruit_market/core/widgets/inputs/custom_text_field.dart';

class PasswordFormField extends StatelessWidget {
  final void Function()? togglePasswordInvisibility;
  final ValueNotifier<bool> _isPasswordShown;
  final TextEditingController _passwordController;

  const PasswordFormField({
    super.key,
    required ValueNotifier<bool> isPasswordShown,
    required TextEditingController passwordController,
    this.togglePasswordInvisibility,
  })  : _isPasswordShown = isPasswordShown,
        _passwordController = passwordController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isPasswordShown,
        builder: (context, value, _) {
          return CustomTextField(
            controller: _passwordController,
            obscureText: !value,
            keyboardType: TextInputType.text,
            enableInteractiveSelection: false,
            validator: _passwordValidator,
            suffixIcon: ToggleInVisibilityButton(
              isShown: value,
              toggleInvisibility: togglePasswordInvisibility,
            ),
          );
        });
  }

  String? _passwordValidator(String? password) {
    if (password == null || password.isEmpty) return 'Required field';
    if (password.length < 8) return 'Password must be at least 3 characters';
    if (!password.isStrongPassword) return 'Password is not strong';
    return null;
  }
}
