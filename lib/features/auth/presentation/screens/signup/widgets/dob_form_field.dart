import 'package:flutter/material.dart';
import 'package:fruit_market/core/widgets/inputs/custom_text_field.dart';
import 'package:intl/intl.dart';

class DOBFormField extends StatelessWidget {
  const DOBFormField({
    super.key,
    required TextEditingController dobController,
  }) : _dobController = dobController;

  final TextEditingController _dobController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _dobController,
      readOnly: true,
      onTap: () => _chooseDate(context),
    );
  }

  void _chooseDate(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date == null) return;
    _dobController.text = DateFormat('yyyy-MM-dd').format(date);
  }
}
