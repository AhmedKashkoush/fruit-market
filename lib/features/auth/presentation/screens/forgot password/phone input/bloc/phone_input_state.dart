part of 'phone_input_bloc.dart';

sealed class PhoneInputState extends Equatable {
  const PhoneInputState();

  @override
  List<Object> get props => [];
}

final class PhoneInputInitial extends PhoneInputState {}

final class PhoneInputLoadingState extends PhoneInputState {}

final class PhoneInputErrorState extends PhoneInputState {
  final String message;
  final ErrorType errorType;

  const PhoneInputErrorState({
    required this.message,
    required this.errorType,
  });

  @override
  List<Object> get props => [message, errorType];
}

final class PhoneInputSuccessState extends PhoneInputState {
  final String vId;

  const PhoneInputSuccessState({
    required this.vId,
  });

  @override
  List<Object> get props => [vId];
}
