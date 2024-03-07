part of 'password_reset_email_bloc.dart';

sealed class PasswordResetEmailState extends Equatable {
  const PasswordResetEmailState();

  @override
  List<Object> get props => [];
}

final class PasswordResetEmailInitial extends PasswordResetEmailState {}

class PasswordResetEmailLoadingState extends PasswordResetEmailState {}

class PasswordResetEmailSuccessState extends PasswordResetEmailState {}

class PasswordResetEmailErrorState extends PasswordResetEmailState {
  final String message;
  final ErrorType errorType;

  const PasswordResetEmailErrorState(
    this.message, {
    this.errorType = ErrorType.normal,
  });

  @override
  List<Object> get props => [message, errorType];
}
