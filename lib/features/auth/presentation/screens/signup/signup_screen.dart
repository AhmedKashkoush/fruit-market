import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/config/routes/routes.dart';
import 'package:fruit_market/core/utils/app_navigator.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/core/utils/parameters.dart';
import 'package:fruit_market/core/utils/snack_messages.dart';
import 'package:fruit_market/core/widgets/buttons/auth_toggle_widget.dart';
import 'package:fruit_market/core/widgets/buttons/custom_elevated_button.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/bloc/signup_bloc.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/bloc/signup_events.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/bloc/signup_states.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/widgets/address_form_field.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/widgets/confirm_form_field.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/widgets/dob_form_field.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/widgets/email_form_field.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/widgets/full_name_form_field.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/widgets/gender_form_field.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/widgets/password_form_field.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/widgets/phone_form_field.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _isPasswordShown = ValueNotifier<bool>(false),
      _isConfirmShown = ValueNotifier<bool>(false);

  final ValueNotifier<GenderType?> _gender = ValueNotifier<GenderType?>(null);
  final ValueNotifier<String?> _address = ValueNotifier<String?>(null);

  final TextEditingController _fNameController = TextEditingController(),
      _lNameController = TextEditingController(),
      _dobController = TextEditingController(),
      _countryController = TextEditingController(),
      _governorateController = TextEditingController(),
      _cityController = TextEditingController(),
      _streetController = TextEditingController(),
      _emailController = TextEditingController(),
      _phoneController = TextEditingController(),
      _passwordController = TextEditingController(),
      _confirmController = TextEditingController();

  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            reverse: true,
            child: BlocListener<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpErrorState) {
                  showErrorSnackBar(context, state.message,
                      errorType: state.errorType);
                }

                if (state is SignUpSuccessState) {
                  showSuccessSnackBar(
                    context,
                    'Credentials submitted',
                  );
                }

                if (state is EmailVerificationError) {
                  showErrorSnackBar(
                    context,
                    state.message,
                    errorType: state.errorType,
                    actionLabel: 'Retry',
                    onActionTap: () => _sendEmailVerification(context),
                  );
                }

                if (state is EmailVerificationSuccess) {
                  showSuccessSnackBar(
                    context,
                    'Email verification sent to ${state.email}',
                  );
                  _goToLogin(context);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Full Name
                  const LabelWidget(label: 'Enter your full name'),
                  const Gap(2),
                  FullNameFormField(
                    fNameController: _fNameController,
                    lNameController: _lNameController,
                  ),
                  const Gap(10),

                  //Gender
                  const LabelWidget(label: 'Select your gender'),
                  const Gap(2),
                  GenderFormField(gender: _gender),
                  const Gap(10),

                  //DOB
                  const LabelWidget(
                      label: 'Enter your date of birth (optional)'),
                  const Gap(2),
                  DOBFormField(dobController: _dobController),
                  const Gap(10),

                  //Address
                  const LabelWidget(label: 'Add your address'),
                  const Gap(2),
                  AddressFormField(
                    countryController: _countryController,
                    governorateController: _governorateController,
                    cityController: _cityController,
                    streetController: _streetController,
                    isExpanded: _isExpanded,
                  ),
                  const Gap(10),

                  //Email
                  const LabelWidget(label: 'Enter your email address'),
                  const Gap(2),
                  EmailFormField(emailController: _emailController),
                  const Gap(10),

                  //Phone
                  const LabelWidget(label: 'Enter your phone number'),
                  const Gap(2),
                  PhoneFormField(phoneController: _phoneController),
                  const Gap(10),

                  //Password
                  const LabelWidget(label: 'Enter your password'),
                  const Gap(2),
                  PasswordFormField(
                    isPasswordShown: _isPasswordShown,
                    passwordController: _passwordController,
                    togglePasswordInvisibility: _togglePasswordInvisibility,
                  ),
                  const Gap(10),

                  //Confirm
                  const LabelWidget(label: 'Confirm your password'),
                  const Gap(2),
                  ConfirmFormField(
                    isConfirmShown: _isConfirmShown,
                    passwordController: _passwordController,
                    confirmController: _confirmController,
                    toggleConfirmInvisibility: _toggleConfirmInvisibility,
                  ),
                  const Gap(15),

                  //Sign Up Button
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (_, state) => CustomElevatedButton(
                      text: 'Sign up',
                      onPressed: _submit,
                      isLoading: state is SignUpLoadingState ||
                          state is EmailVerificationLoading,
                    ),
                  ),
                  const Gap(5),

                  //Auth Toggle Button
                  BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (_, state) => AuthToggleWidget(
                            text: 'If you already have an account ',
                            buttonText: 'Log in',
                            onTap: state is SignUpLoadingState ||
                                    state is EmailVerificationLoading
                                ? null
                                : () {
                                    _goToLogin(context);
                                  },
                          )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendEmailVerification(BuildContext context) {
    context.read<SignUpBloc>().add(
          SendEmailVerificationEvent(
            LoginParams(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          ),
        );
  }

  void _submit() {
    _address.value =
        '${_streetController.text}, ${_cityController.text}, ${_governorateController.text}, ${_countryController.text}';
    final bool isValid = _formKey.currentState!.validate() &&
        _gender.value != null &&
        _address.value != null;
    if (isValid) {
      _formKey.currentState!.save();
      SignUpParams params = SignUpParams(
        name: '${_fNameController.text.trim()} ${_lNameController.text.trim()}',
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        gender: _gender.value!.name,
        address: _address.value!,
        password: _passwordController.text.trim(),
        birthday: DateTime.tryParse(_dobController.text),
      );

      context.read<SignUpBloc>().add(SignUpSubmitEvent(params));
    } else {
      if (_gender.value == null) {
        showErrorSnackBar(context, 'Please select your gender');
      } else if (_address.value == null && !_isExpanded.value) {
        showErrorSnackBar(context, 'Please add your address');
      }
    }
  }

  void _goToLogin(BuildContext context) {
    pushReplacementNamed(AppRoutes.login, context);
  }

  void _togglePasswordInvisibility() {
    _isPasswordShown.value = !_isPasswordShown.value;
  }

  void _toggleConfirmInvisibility() {
    _isConfirmShown.value = !_isConfirmShown.value;
  }
}
