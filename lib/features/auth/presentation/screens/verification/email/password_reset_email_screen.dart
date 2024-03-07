import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/utils/app_navigator.dart';
import 'package:fruit_market/core/utils/snack_messages.dart';
import 'package:fruit_market/core/widgets/headers/transparent_app_bar.dart';
import 'package:fruit_market/core/widgets/texts/label_widget.dart';
import 'package:fruit_market/features/auth/presentation/screens/verification/email/bloc/password_reset_email_bloc.dart';
import 'package:gap/gap.dart';

class PasswordResetEmailScreen extends StatefulWidget {
  final String email;
  const PasswordResetEmailScreen({super.key, required this.email});

  @override
  State<PasswordResetEmailScreen> createState() =>
      _PasswordResetEmailScreenState();
}

class _PasswordResetEmailScreenState extends State<PasswordResetEmailScreen> {
  @override
  void initState() {
    context.read<PasswordResetEmailBloc>().add(
          SendPasswordResetEmailEvent(widget.email),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      body: Center(
        child: BlocConsumer<PasswordResetEmailBloc, PasswordResetEmailState>(
          listener: (context, state) {
            if (state is PasswordResetEmailSuccessState) {
              showSuccessSnackBar(
                  context, 'A password reset email was sent to your mail');
              pop(context);
            } else if (state is PasswordResetEmailErrorState) {
              showErrorSnackBar(
                context,
                state.message,
                errorType: state.errorType,
              );
              pop(context);
            }
          },
          builder: (_, state) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is PasswordResetEmailLoadingState) ...[
                const CircularProgressIndicator(),
                const Gap(10),
                LabelWidget(label: 'Processing ${widget.email}...'),
              ],
              if (state is PasswordResetEmailErrorState) ...[
                LabelWidget(label: 'Error sending email to ${widget.email}'),
                IconButton.filled(
                  onPressed: _resend,
                  icon: const Icon(CupertinoIcons.refresh_circled),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  void _resend() {
    context
        .read<PasswordResetEmailBloc>()
        .add(ReSendPasswordResetEmailEvent(widget.email));
  }
}
