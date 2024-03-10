import 'package:flutter/material.dart';
import 'package:fruit_market/core/extensions/string_validations.dart';
import 'package:fruit_market/core/widgets/inputs/phone_field.dart';

class PhoneFormField extends StatelessWidget {
  const PhoneFormField({
    super.key,
    required TextEditingController phoneController,
  }) : _phoneController = phoneController;

  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return PhoneField(
      controller: _phoneController,
      validator: _phoneValidator,
    );
  }

  String? _phoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) return 'Required field';
    if (phone.length < 10) return 'Phone number must be 10 digits';
    if (!phone.isPhone) return 'Invalid phone number';
    return null;
  }
}
