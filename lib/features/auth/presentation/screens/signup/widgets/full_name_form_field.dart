import 'package:flutter/material.dart';
import 'package:fruit_market/core/widgets/inputs/custom_text_field.dart';
import 'package:gap/gap.dart';

class FullNameFormField extends StatelessWidget {
  const FullNameFormField({
    super.key,
    required TextEditingController fNameController,
    required TextEditingController lNameController,
  })  : _fNameController = fNameController,
        _lNameController = lNameController;

  final TextEditingController _fNameController;
  final TextEditingController _lNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: CustomTextField(
          controller: _fNameController,
          validator: _nameValidator,
        )),
        const Gap(4),
        Expanded(
            child: CustomTextField(
          controller: _lNameController,
          validator: _nameValidator,
        )),
      ],
    );
  }

  String? _nameValidator(String? name) {
    if (name == null || name.isEmpty) return 'Required field';
    if (name.length < 3) return 'Name must be at least 3 characters';
    return null;
  }
}
