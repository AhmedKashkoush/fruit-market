import 'package:equatable/equatable.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/features/auth/domain/entities/user.dart';

abstract class SignUpState extends Equatable {}

class SignUpInitialState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpSuccessState extends SignUpState {
  final User user;

  SignUpSuccessState(this.user);
  @override
  List<Object?> get props => [user];
}

class SignUpLoadingState extends SignUpState {
  @override
  List<Object?> get props => [];
}

class SignUpErrorState extends SignUpState {
  final String message;
  final ErrorType errorType;

  SignUpErrorState(
    this.message, {
    this.errorType = ErrorType.normal,
  });
  @override
  List<Object?> get props => [message, errorType];
}

class EmailVerificationLoading extends SignUpState {
  @override
  List<Object?> get props => [];
}

class EmailVerificationSuccess extends SignUpState {
  final String email;

  EmailVerificationSuccess(this.email);
  @override
  List<Object?> get props => [email];
}

class EmailVerificationError extends SignUpState {
  final String message;
  final ErrorType errorType;
  EmailVerificationError(
      {required this.message, this.errorType = ErrorType.normal});
  @override
  List<Object?> get props => [message, errorType];
}
