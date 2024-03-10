import 'package:flutter/material.dart';
import 'package:fruit_market/core/extensions/string_validations.dart';
import 'package:fruit_market/core/widgets/inputs/custom_text_field.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: _emailValidator,
    );
  }

  String? _emailValidator(String? email) {
    if (email == null || email.isEmpty) return 'Required field';
    if (!email.isEmail) return 'Invalid email address';
    return null;
  }
}
