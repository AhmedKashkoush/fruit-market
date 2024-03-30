import 'package:equatable/equatable.dart';
import 'package:fruit_market/core/utils/partameters.dart';

abstract class LoginEvent extends Equatable {}

class LoginWithEmailAndPasswordEvent extends LoginEvent {
  final LoginParams params;
  LoginWithEmailAndPasswordEvent(this.params);

  @override
  List<Object?> get props => [params];
}

class LoginWithGoogleEvent extends LoginEvent {
  LoginWithGoogleEvent();

  @override
  List<Object?> get props => [];
}

class LoginWithFacebookEvent extends LoginEvent {
  LoginWithFacebookEvent();

  @override
  List<Object?> get props => [];
}

class SendEmailVerificationEvent extends LoginEvent {
  final LoginParams params;
  SendEmailVerificationEvent(this.params);

  @override
  List<Object?> get props => [params];
}
