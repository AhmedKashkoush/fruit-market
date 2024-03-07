part of 'password_reset_email_bloc.dart';

sealed class PasswordResetEmailEvent extends Equatable {
  const PasswordResetEmailEvent();

  @override
  List<Object> get props => [];
}

class SendPasswordResetEmailEvent extends PasswordResetEmailEvent {
  final String email;

  const SendPasswordResetEmailEvent(this.email);

  @override
  List<Object> get props => [email];
}

class ReSendPasswordResetEmailEvent extends SendPasswordResetEmailEvent {
  const ReSendPasswordResetEmailEvent(super.email);
}
