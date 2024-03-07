import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/core/utils/app_navigator.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/core/widgets/buttons/custom_elevated_button.dart';
import 'package:fruit_market/core/widgets/buttons/custom_selectable_list_title.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';
import 'package:fruit_market/core/widgets/headers/transparent_app_bar.dart';
import 'package:gap/gap.dart';

class ChooseVerificationMethodScreen extends StatefulWidget {
  final String emailRoute, phoneRoute;
  const ChooseVerificationMethodScreen({
    super.key,
    required this.emailRoute,
    required this.phoneRoute,
  });

  @override
  State<ChooseVerificationMethodScreen> createState() =>
      _ChooseVerificationMethodScreenState();
}

class _ChooseVerificationMethodScreenState
    extends State<ChooseVerificationMethodScreen> {
  final ValueNotifier<VerificationMethod?> _method =
      ValueNotifier<VerificationMethod?>(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ValueListenableBuilder<VerificationMethod?>(
              valueListenable: _method,
              builder: (context, value, _) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LabelWidget(
                      label: 'Choose a method for password reset',
                    ),
                    const Gap(5),
                    CustomeSelectableListTile<VerificationMethod?>(
                      groupValue: value,
                      value: VerificationMethod.mail,
                      icon: CupertinoIcons.at,
                      label: 'Send mail',
                      onChanged: _onChooseMethod,
                    ),
                    const Gap(2),
                    CustomeSelectableListTile<VerificationMethod?>(
                      groupValue: value,
                      value: VerificationMethod.sms,
                      icon: CupertinoIcons.mail_solid,
                      label: 'SMS',
                      onChanged: _onChooseMethod,
                    ),
                    const Gap(15),
                    CustomElevatedButton(
                      text: 'Confirm',
                      onPressed: value == null ? null : _goToScreen,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void _onChooseMethod(VerificationMethod? value) {
    _method.value = value;
  }

  void _goToScreen() {
    if (_method.value == VerificationMethod.mail) {
      pushReplacementNamed(widget.emailRoute, context);
    } else {
      pushReplacementNamed(widget.phoneRoute, context);
    }
  }
}
