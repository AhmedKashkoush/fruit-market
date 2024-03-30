import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/core/utils/partameters.dart';
import 'package:fruit_market/features/auth/domain/entities/user.dart';
import 'package:fruit_market/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/bloc/signup_events.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/bloc/signup_states.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  final SendEmailVerificationUseCase sendEmailVerificationUseCase;
  SignUpBloc(this.signUpUseCase, this.sendEmailVerificationUseCase)
      : super(SignUpInitialState()) {
    on<SignUpSubmitEvent>(_signupSubmit);
    on<SendEmailVerificationEvent>(_sendEmailVerification);
  }

  FutureOr<void> _signupSubmit(
    SignUpSubmitEvent event,
    Emitter<dynamic> emit,
  ) async {
    emit(SignUpLoadingState());
    final Either<Failure, User> result = await signUpUseCase(event.params);
    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case AuthFailure:
            emit(
              SignUpErrorState(
                failure.message,
                errorType: ErrorType.auth,
              ),
            );
            break;
          case ConnectionFailure:
            emit(
              SignUpErrorState(
                failure.message,
                errorType: ErrorType.network,
              ),
            );
            break;
          default:
            emit(
              SignUpErrorState(failure.message),
            );
        }
      },
      (user) {
        emit(
        SignUpSuccessState(user),
        );
        add(
          SendEmailVerificationEvent(
            LoginParams(
              email: event.params.email,
              password: event.params.password,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _sendEmailVerification(
      SendEmailVerificationEvent event, Emitter<SignUpState> emit) async {
    emit(EmailVerificationLoading());
    final Either<Failure, Unit> result = await sendEmailVerificationUseCase(
      event.params,
    );
    result.fold((failure) {
      emit(
        EmailVerificationError(
          message: failure.message,
          errorType: ErrorType.verification,
        ),
      );
    }, (_) {
      emit(EmailVerificationSuccess(event.params.email));
    });
  }

}
