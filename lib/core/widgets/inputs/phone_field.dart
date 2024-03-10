import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_market/core/widgets/inputs/custom_text_field.dart';
import 'package:gap/gap.dart';

class PhoneField extends StatefulWidget {
  final void Function(CountryCode)? onCodeChange;
  final void Function(String)? onTextChanged;
  final int maxLength;
  final TextEditingController? controller;
  final String initialCode;
  final String? Function(String?)? validator;
  const PhoneField({
    super.key,
    this.onCodeChange,
    this.onTextChanged,
    this.maxLength = 10,
    this.initialCode = '+20',
    this.controller,
    this.validator,
  });

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  String _phone = '';
  late String _code;
  final TextEditingController _phoneController = TextEditingController();
  @override
  void initState() {
    _code = widget.initialCode;
    widget.controller?.text = '$_code$_phone';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: CountryCodePicker(
            onChanged: (code) {
              _code = code.dialCode!;
              if (widget.controller != null) {
                widget.controller!.text = '$_code$_phone';
              }
              if (widget.onCodeChange != null) {
                widget.onCodeChange!(code);
              }
            },
            initialSelection: widget.initialCode,
          ),
        ),
        const Gap(5),
        Expanded(
          flex: 2,
          child: CustomTextField(
            maxLength: widget.maxLength,
            enableCounter: false,
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            validator: (_) {
              if (widget.validator != null) {
                return widget.validator!(widget.controller!.text);
              }
              return null;
            },
            onChanged: (value) {
              _phone = _phoneController.text;
              if (widget.controller != null) {
                widget.controller!.text = '$_code$_phone';
              }
              if (widget.onTextChanged != null) {
                widget.onTextChanged!(value);
              }
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ],
    );
  }
}
