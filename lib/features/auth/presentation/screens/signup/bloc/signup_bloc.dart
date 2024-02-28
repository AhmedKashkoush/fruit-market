import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/features/auth/domain/entities/user.dart';
import 'package:fruit_market/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/bloc/signup_events.dart';
import 'package:fruit_market/features/auth/presentation/screens/signup/bloc/signup_states.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  SignUpBloc(this.signUpUseCase) : super(SignUpInitialState()) {
    on<SignUpSubmitEvent>(_signupSubmit);
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
      (user) => emit(
        SignUpSuccessState(user),
      ),
    );
  }
}
