part of 'phone_input_bloc.dart';

sealed class PhoneInputEvent extends Equatable {
  const PhoneInputEvent();

  @override
  List<Object> get props => [];
}

class PhoneInputSendOTPEvent extends PhoneInputEvent {
  final String phoneNumber;
  const PhoneInputSendOTPEvent(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}
