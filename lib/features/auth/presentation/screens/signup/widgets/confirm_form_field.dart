import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/core/widgets/buttons/toggle_invisibility_button.dart';
import 'package:fruit_market/core/widgets/inputs/custom_text_field.dart';

class ConfirmFormField extends StatelessWidget {
  final void Function()? toggleConfirmInvisibility;

  final ValueNotifier<bool> _isConfirmShown;
  final TextEditingController _confirmController, _passwordController;

  const ConfirmFormField({
    super.key,
    required ValueNotifier<bool> isConfirmShown,
    required TextEditingController passwordController,
    confirmController,
    this.toggleConfirmInvisibility,
  })  : _isConfirmShown = isConfirmShown,
        _passwordController = passwordController,
        _confirmController = confirmController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isConfirmShown,
        builder: (context, value, _) {
          return CustomTextField(
            controller: _confirmController,
            obscureText: !value,
            keyboardType: TextInputType.text,
            enableInteractiveSelection: false,
            validator: _confirmValidator,
            suffixIcon: ToggleInVisibilityButton(
              toggleInvisibility: toggleConfirmInvisibility,
              isShown: value,
            ),
          );
        });
  }

  String? _confirmValidator(String? confirm) {
    if (confirm == null || confirm.isEmpty) return 'Required field';
    if (confirm != _passwordController.text) {
      return 'This field is not matched with password you typed';
    }
    return null;
  }
}
