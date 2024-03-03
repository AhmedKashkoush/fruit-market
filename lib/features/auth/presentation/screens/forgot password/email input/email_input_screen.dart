import 'package:flutter/material.dart';
import 'package:fruit_market/core/extensions/string_validations.dart';
import 'package:fruit_market/core/widgets/custom_elevated_button.dart';
import 'package:fruit_market/core/widgets/custom_text_field.dart';
import 'package:fruit_market/core/widgets/label_widget.dart';
import 'package:fruit_market/core/widgets/transparent_app_bar.dart';
import 'package:gap/gap.dart';

class EmailInputScreen extends StatefulWidget {
  const EmailInputScreen({super.key});

  @override
  State<EmailInputScreen> createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final ValueNotifier<String> _email = ValueNotifier<String>('');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ValueListenableBuilder<String>(
              valueListenable: _email,
              builder: (context, value, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LabelWidget(
                      label: 'Enter your email',
                    ),
                    const Gap(5),
                    CustomTextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: _onTextChanged,
                    ),
                    const Gap(15),
                    CustomElevatedButton(
                      text: 'Confirm',
                      onPressed: !value.isEmail ? null : _goToCodeScreen,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void _onTextChanged(String email) {
    _email.value = email;
  }

  void _goToCodeScreen() {}
}
