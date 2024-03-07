import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_market/core/widgets/inputs/custom_text_field.dart';
import 'package:gap/gap.dart';

class PhoneField extends StatelessWidget {
  final void Function(CountryCode)? onCodeChange;
  final void Function(String)? onTextChanged;
  final int maxLength;
  final String initialCode;
  const PhoneField({
    super.key,
    this.onCodeChange,
    this.onTextChanged,
    this.maxLength = 10,
    this.initialCode = 'eg',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CountryCodePicker(
            onChanged: onCodeChange,
            initialSelection: initialCode,
          ),
        ),
        const Gap(5),
        Expanded(
          flex: 2,
          child: CustomTextField(
            maxLength: maxLength,
            enableCounter: false,
            keyboardType: TextInputType.phone,
            onChanged: onTextChanged,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ],
    );
  }
}
