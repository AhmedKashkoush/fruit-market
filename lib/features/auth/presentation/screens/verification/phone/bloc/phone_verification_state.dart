part of 'phone_verification_bloc.dart';

abstract class PhoneVerificationState extends Equatable {
  const PhoneVerificationState();

  @override
  List<Object?> get props => [];
}

class PhoneVerificationInitial extends PhoneVerificationState {}

class PhoneVerificationLoading extends PhoneVerificationState {}

class CodeResendError extends PhoneVerificationState {
  final String message;
  final ErrorType errorType;
  const CodeResendError({
    required this.message,
    this.errorType = ErrorType.normal,
  });

  @override
  List<Object?> get props => [message, errorType];
}

class PhoneVerificationError extends PhoneVerificationState {
  final String message;
  final ErrorType errorType;
  const PhoneVerificationError({
    required this.message,
    this.errorType = ErrorType.normal,
  });

  @override
  List<Object?> get props => [message, errorType];
}

class CodeResendSuccess extends PhoneVerificationState {
  final String verificationId;
  const CodeResendSuccess(this.verificationId);

  @override
  List<Object?> get props => [verificationId];
}

class PhoneVerificationSuccess extends PhoneVerificationState {
  const PhoneVerificationSuccess();

  @override
  List<Object?> get props => [];
}
