import 'package:flutter/material.dart';
import 'package:fruit_market/core/utils/snack_messages.dart';
import 'package:fruit_market/core/widgets/headers/transparent_app_bar.dart';
import 'package:fruit_market/core/widgets/inputs/custom_otp_field.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';
import 'package:fruit_market/core/widgets/visuals/otp_enter_widget.dart';
import 'package:gap/gap.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const OTPEnterWidget(),
              const Gap(10),
              const LabelWidget(
                label: 'Enter the code sent to your phone number',
              ),
              const Gap(5),
              CustomOTPField(
                controller: controller,
                onCodeEnd: () {
                  showSuccessSnackBar(context, 'Code Submitted');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
