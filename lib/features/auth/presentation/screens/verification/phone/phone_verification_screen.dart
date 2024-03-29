import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fruit_market/core/utils/snack_messages.dart';
import 'package:fruit_market/core/widgets/headers/transparent_app_bar.dart';
import 'package:fruit_market/core/widgets/inputs/custom_otp_field.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';
import 'package:fruit_market/core/widgets/visuals/otp_enter_widget.dart';
import 'package:fruit_market/features/auth/presentation/screens/verification/phone/widgets/resend_button.dart';
import 'package:fruit_market/features/auth/presentation/screens/verification/phone/widgets/timer_text.dart';
import 'package:gap/gap.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<int> _timerNotifier = ValueNotifier<int>(0);
  Timer? _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    if (_timerNotifier.value > 0) return;
    _timerNotifier.value = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerNotifier.value == 0) {
        _timer?.cancel();
      }
      _timerNotifier.value--;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(8.0),
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
              const Gap(5),
              ValueListenableBuilder(
                  valueListenable: _timerNotifier,
                  builder: (context, value, _) {
                    if (value > 0) {
                      return TimerText(
                        seconds: value,
                      );
                    }
                    return ResendButton(
                      onResend: _resendCode,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _resendCode() {
    _startTimer();
  }
}


