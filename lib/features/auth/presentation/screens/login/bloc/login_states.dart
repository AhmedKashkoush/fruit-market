import 'package:equatable/equatable.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/features/auth/domain/entities/user.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  final User user;

  LoginSuccessState(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}
class GoogleLoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class FacebookLoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginErrorState extends LoginState {
  final String message;
  final ErrorType errorType;

  LoginErrorState(
    this.message, {
    this.errorType = ErrorType.normal,
  });
  @override
  List<Object?> get props => [message, errorType];
}


class EmailVerificationLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class EmailVerificationSuccess extends LoginState {
  final String email;

  EmailVerificationSuccess(this.email);
  @override
  List<Object?> get props => [email];
}

class EmailVerificationError extends LoginState {
  final String message;
  final ErrorType errorType;
  EmailVerificationError(
      {required this.message, this.errorType = ErrorType.normal});
  @override
  List<Object?> get props => [message, errorType];
}
