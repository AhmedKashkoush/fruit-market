import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/extensions/string_validations.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/features/auth/domain/entities/user.dart';
import 'package:fruit_market/features/auth/domain/usecases/login_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/sign_in_with_facebook_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:fruit_market/features/auth/presentation/screens/login/bloc/login_events.dart';
import 'package:fruit_market/features/auth/presentation/screens/login/bloc/login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignInWithFacebookUseCase signInWithFacebookUseCase;

  LoginBloc(
    this.loginUseCase,
    this.signInWithGoogleUseCase,
    this.signInWithFacebookUseCase,
  ) : super(LoginInitialState()) {
    on<LoginWithEmailAndPasswordEvent>(_loginWithEmailAndPassword);
    on<LoginWithGoogleEvent>(_loginWithGoogle);
    on<LoginWithFacebookEvent>(_loginWithFacebook);
  }

  FutureOr<void> _loginWithEmailAndPassword(
    LoginWithEmailAndPasswordEvent event,
    Emitter<LoginState> emit,
  ) async {
    if (event.params.email.isEmpty && event.params.password.isEmpty) {
      emit(
        LoginErrorState(
          'Please fill the required credentials',
          errorType: ErrorType.auth,
        ),
      );
      emit(LoginInitialState());
    } else if (event.params.email.isEmpty) {
      emit(
        LoginErrorState(
          'Please enter your email or phone',
          errorType: ErrorType.auth,
        ),
      );
      emit(LoginInitialState());
    } else if (event.params.password.isEmpty) {
      emit(
        LoginErrorState(
          'Please your password',
          errorType: ErrorType.auth,
        ),
      );
      emit(LoginInitialState());
    } else {
      if (!event.params.email.isEmail && !event.params.email.isPhone) {
        emit(
          LoginErrorState(
            'Please enter a valid email or phone',
            errorType: ErrorType.normal,
          ),
        );
        emit(LoginInitialState());
      } else {
        emit(LoginLoadingState());

    final Either<Failure, User> result = await loginUseCase(event.params);

    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case AuthFailure:
            emit(
              LoginErrorState(
                failure.message,
                errorType: ErrorType.auth,
              ),
            );
            break;
          case ConnectionFailure:
            emit(
              LoginErrorState(
                failure.message,
                errorType: ErrorType.network,
              ),
            );
            break;
          default:
            emit(
              LoginErrorState(failure.message),
            );
        }
      },
      (user) => emit(
        LoginSuccessState(user),
      ),
        );       
      }
    }
  }

  FutureOr<void> _loginWithGoogle(
    LoginWithGoogleEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(GoogleLoginLoadingState());

    final Either<Failure, User> result = await signInWithGoogleUseCase();

    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case AuthFailure:
            emit(
              LoginErrorState(
                failure.message,
                errorType: ErrorType.auth,
              ),
            );
            break;
          case ConnectionFailure:
            emit(
              LoginErrorState(
                failure.message,
                errorType: ErrorType.network,
              ),
            );
            break;
          default:
            emit(
              LoginErrorState(failure.message),
            );
        }
      },
      (user) => emit(
        LoginSuccessState(user),
      ),
    );
  }

  FutureOr<void> _loginWithFacebook(
    LoginWithFacebookEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(FacebookLoginLoadingState());

    final Either<Failure, User> result = await signInWithFacebookUseCase();

    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case AuthFailure:
            emit(
              LoginErrorState(
                failure.message,
                errorType: ErrorType.auth,
              ),
            );
            break;
          case ConnectionFailure:
            emit(
              LoginErrorState(
                failure.message,
                errorType: ErrorType.network,
              ),
            );
            break;
          default:
            emit(
              LoginErrorState(failure.message),
            );
        }
      },
      (user) => emit(
        LoginSuccessState(user),
      ),
    );
  }
}
