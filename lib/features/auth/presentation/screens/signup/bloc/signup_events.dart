import 'package:equatable/equatable.dart';
import 'package:fruit_market/core/utils/partameters.dart';

abstract class SignUpEvent extends Equatable {}

class SignUpSubmitEvent extends SignUpEvent {
  final SignUpParams params;

  SignUpSubmitEvent(this.params);

  @override
  List<Object?> get props => [params];
}

class SendEmailVerificationEvent extends SignUpEvent {
  final LoginParams params;
  SendEmailVerificationEvent(this.params);
  @override
  List<Object?> get props => [params];
}
