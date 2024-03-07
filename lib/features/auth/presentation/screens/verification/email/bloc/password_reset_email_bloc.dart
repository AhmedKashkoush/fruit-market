import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/features/auth/domain/usecases/send_password_reset_email_usecase.dart';

part 'password_reset_email_event.dart';
part 'password_reset_email_state.dart';

class PasswordResetEmailBloc
    extends Bloc<PasswordResetEmailEvent, PasswordResetEmailState> {
  final SendPasswordResetEmailUseCase sendPasswordResetEmailUsecase;
  PasswordResetEmailBloc(this.sendPasswordResetEmailUsecase)
      : super(PasswordResetEmailInitial()) {
    on<SendPasswordResetEmailEvent>(
      _sendPasswordResetEmail,
      transformer: droppable(),
    );

    on<ReSendPasswordResetEmailEvent>(
      _resendPasswordResetEmail,
      transformer: droppable(),
    );
  }

  FutureOr<void> _sendPasswordResetEmail(SendPasswordResetEmailEvent event,
      Emitter<PasswordResetEmailState> emit) async {
    emit(PasswordResetEmailLoadingState());
    final Either<Failure, Unit> result =
        await sendPasswordResetEmailUsecase(event.email);
    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case AuthFailure:
            emit(
              PasswordResetEmailErrorState(
                failure.message,
                errorType: ErrorType.auth,
              ),
            );
            break;
          case ConnectionFailure:
            emit(
              PasswordResetEmailErrorState(
                failure.message,
                errorType: ErrorType.network,
              ),
            );
            break;
          default:
            emit(
              PasswordResetEmailErrorState(failure.message),
            );
        }
      },
      (_) => emit(
        PasswordResetEmailSuccessState(),
      ),
    );
  }

  FutureOr<void> _resendPasswordResetEmail(ReSendPasswordResetEmailEvent event,
      Emitter<PasswordResetEmailState> emit) async {
    emit(PasswordResetEmailLoadingState());
    final Either<Failure, Unit> result =
        await sendPasswordResetEmailUsecase(event.email);
    result.fold(
      (failure) {
        switch (failure.runtimeType) {
          case AuthFailure:
            emit(
              PasswordResetEmailErrorState(
                failure.message,
                errorType: ErrorType.auth,
              ),
            );
            break;
          case ConnectionFailure:
            emit(
              PasswordResetEmailErrorState(
                failure.message,
                errorType: ErrorType.network,
              ),
            );
            break;
          default:
            emit(
              PasswordResetEmailErrorState(failure.message),
            );
        }
      },
      (_) => emit(
        PasswordResetEmailSuccessState(),
      ),
    );
  }
}
