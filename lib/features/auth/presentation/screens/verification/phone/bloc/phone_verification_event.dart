part of 'phone_verification_bloc.dart';

abstract class PhoneVerificationEvent extends Equatable {
  const PhoneVerificationEvent();
  @override
  List<Object> get props => [];
}

class VerifyPhoneEvent extends PhoneVerificationEvent {
  final VerifyPhoneParams params;
  const VerifyPhoneEvent({
    required this.params,
  });

  @override
  List<Object> get props => [params];
}

class ReSendPhoneVerificationCodeEvent extends PhoneVerificationEvent {
  final String phoneNumber;
  const ReSendPhoneVerificationCodeEvent({required this.phoneNumber});
  @override
  List<Object> get props => [phoneNumber];
}
