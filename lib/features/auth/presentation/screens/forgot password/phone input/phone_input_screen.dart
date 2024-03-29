import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/core/extensions/string_validations.dart';
import 'package:fruit_market/core/utils/app_navigator.dart';
import 'package:fruit_market/core/utils/snack_messages.dart';
import 'package:fruit_market/core/widgets/buttons/custom_elevated_button.dart';
import 'package:fruit_market/core/widgets/inputs/phone_field.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';
import 'package:fruit_market/core/widgets/headers/transparent_app_bar.dart';
import 'package:fruit_market/features/auth/presentation/screens/forgot%20password/phone%20input/bloc/phone_input_bloc.dart';
import 'package:gap/gap.dart';
import 'package:fruit_market/core/utils/locator.dart';

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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PhoneInputBloc>(),
      child: Scaffold(
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
                      PhoneField(
                        onCodeChange: _onCodeChange,
                        onTextChanged: _onTextChanged,
                      ),
                      const Gap(15),
                      BlocConsumer<PhoneInputBloc, PhoneInputState>(
                        listener: (context, state) {
                          if (state is PhoneInputErrorState) {
                            showErrorSnackBar(context, state.message,
                                errorType: state.errorType);
                          }

                          if (state is PhoneInputSuccessState) {
                            _goToCodeScreen();
                          }
                        },
                        builder: (context, state) {
                          return CustomElevatedButton(
                            text: 'Confirm',
                            isLoading: state is PhoneInputLoadingState,
                            onPressed: !value.isPhone ||
                                    _phone.value.length < _maxLength ||
                                    state is PhoneInputLoadingState
                                ? null
                                : () => _sendCode(context),
                          );
                        },
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  void _onTextChanged(String phone) {
    _phone.value = phone;
    _text.value = '${_code.value}$phone';
  }

  void _goToCodeScreen() {
    pushReplacementNamed(AppRoutes.phoneVerification, context);
  }

  void _onCodeChange(CountryCode value) {
    _code.value = value.dialCode!;
    _text.value = '${_code.value}${_phone.value}';
  }
  
  void _sendCode(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<PhoneInputBloc>().add(PhoneInputSendOTPEvent(_text.value));
  }
}
