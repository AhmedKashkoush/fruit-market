import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/core/extensions/string_validations.dart';
import 'package:fruit_market/core/widgets/custom_elevated_button.dart';
import 'package:fruit_market/core/widgets/custom_text_field.dart';
import 'package:fruit_market/core/widgets/label_widget.dart';
import 'package:fruit_market/core/widgets/transparent_app_bar.dart';
import 'package:gap/gap.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  State<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  final ValueNotifier<String> _phone = ValueNotifier<String>(''),
      _code = ValueNotifier<String>('+20'),
      _text = ValueNotifier<String>('');
  final int _maxLength = 10;
  final String _initialCode = 'eg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ValueListenableBuilder<String>(
              valueListenable: _text,
              builder: (context, value, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LabelWidget(
                      label: 'Enter your phone number',
                    ),
                    const Gap(5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CountryCodePicker(
                            onChanged: _onCodeChange,
                            initialSelection: _initialCode,
                          ),
                        ),
                        const Gap(5),
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            maxLength: _maxLength,
                            enableCounter: false,
                            keyboardType: TextInputType.phone,
                            onChanged: _onTextChanged,
                          ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    CustomElevatedButton(
                      text: 'Confirm',
                      onPressed:
                          !value.isPhone || _phone.value.length < _maxLength
                              ? null
                              : _goToCodeScreen,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void _onTextChanged(String phone) {
    _phone.value = phone;
    _text.value = '${_code.value}$phone';
  }

  void _goToCodeScreen() {}

  void _onCodeChange(CountryCode value) {
    _code.value = value.dialCode!;
    _text.value = '${_code.value}${_phone.value}';
  }
}
