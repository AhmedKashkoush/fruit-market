import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/utils/locator.dart';
import 'package:fruit_market/core/utils/partameters.dart';
import 'package:fruit_market/core/utils/snack_messages.dart';
import 'package:fruit_market/core/widgets/headers/transparent_app_bar.dart';
import 'package:fruit_market/core/widgets/inputs/custom_otp_field.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';
import 'package:fruit_market/core/widgets/visuals/otp_enter_widget.dart';
import 'package:fruit_market/features/auth/presentation/screens/verification/phone/bloc/phone_verification_bloc.dart';
import 'package:fruit_market/features/auth/presentation/screens/verification/phone/widgets/resend_button.dart';
import 'package:fruit_market/features/auth/presentation/screens/verification/phone/widgets/timer_text.dart';
import 'package:gap/gap.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final String verificationId, phoneNumber;

  const PhoneVerificationScreen(
      {super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<int> _timerNotifier = ValueNotifier<int>(0);
  Timer? _timer;

  late String verificationId = widget.verificationId; 

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
    return BlocProvider(
      create: (_) => sl<PhoneVerificationBloc>(),
      child: BlocListener<PhoneVerificationBloc, PhoneVerificationState>(
        listener: (_, state) {
          if (state is PhoneVerificationError) {
            showErrorSnackBar(context, state.message,
                errorType: state.errorType);
          }

          if (state is CodeResendError) {
            showErrorSnackBar(context, state.message,
                errorType: state.errorType);
          }

          if (state is CodeResendSuccess) {
            verificationId = state.verificationId;
          }

          if (state is PhoneVerificationSuccess) {
            showSuccessSnackBar(context, 'Code Submitted');
          }
        },
        child: Builder(builder: (context) {
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
                    LabelWidget(
                      label: 'Enter the code sent to ${widget.phoneNumber}',
                    ),
                    const Gap(5),
                    CustomOTPField(
                      controller: controller,
                      onCodeEnd: _verifyCode,
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
        }),
      ),
    );
  }

  void _verifyCode() {
    context.read<PhoneVerificationBloc>().add(
          VerifyPhoneEvent(
            params: VerifyPhoneParams(
              verificationId: verificationId,
              otp: controller.text,
            ),
          ),
        );
  }

  void _resendCode() {
    _startTimer();
    
    context.read<PhoneVerificationBloc>().add(
          ReSendPhoneVerificationCodeEvent(
            phoneNumber: widget.phoneNumber,
          ),
        );
  }
}


