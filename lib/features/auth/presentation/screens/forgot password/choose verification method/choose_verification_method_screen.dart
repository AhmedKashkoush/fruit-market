import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/core/utils/app_navigator.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/core/widgets/custom_elevated_button.dart';
import 'package:fruit_market/core/widgets/custom_selectable_list_title.dart';
import 'package:fruit_market/core/widgets/label_widget.dart';
import 'package:fruit_market/core/widgets/transparent_app_bar.dart';
import 'package:gap/gap.dart';

class ChooseVerificationMethodScreen extends StatefulWidget {
  const ChooseVerificationMethodScreen({super.key});

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
                      label: 'Choose a method to send a verification code to',
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
                      onPressed: value == null ? null : _goToInputScreen,
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

  void _goToInputScreen() {
    if (_method.value == VerificationMethod.mail) {
      pushReplacementNamed(AppRoutes.emailInput, context);
    } else {
      pushReplacementNamed(AppRoutes.phoneInput, context);
    }
  }
}
