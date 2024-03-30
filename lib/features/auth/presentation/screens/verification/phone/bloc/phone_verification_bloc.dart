import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/core/utils/partameters.dart';
import 'package:fruit_market/features/auth/domain/usecases/send_phone_verification_usecase.dart';
import 'package:fruit_market/features/auth/domain/usecases/verify_phone_usecase.dart';

part 'phone_verification_event.dart';
part 'phone_verification_state.dart';

class PhoneVerificationBloc
    extends Bloc<PhoneVerificationEvent, PhoneVerificationState> {
  final SendPhoneVerificationUseCase sendPhoneVerificationUseCase;
  final VerifyPhoneUseCase verifyPhoneUseCase;
  PhoneVerificationBloc(
    this.sendPhoneVerificationUseCase,
    this.verifyPhoneUseCase,
  ) : super(PhoneVerificationInitial()) {
    on<ReSendPhoneVerificationCodeEvent>(_resendPhoneVerificationCode);
    on<VerifyPhoneEvent>(_verifyPhone);
  }

  FutureOr<void> _resendPhoneVerificationCode(
      ReSendPhoneVerificationCodeEvent event,
      Emitter<PhoneVerificationState> emit) async {
    final Either<Failure, String> result =
        await sendPhoneVerificationUseCase(event.phoneNumber);

    result.fold((failure) {
      emit(CodeResendError(
        message: failure.message,
        errorType: ErrorType.normal,
      ));
    }, (vId) {
      emit(
        CodeResendSuccess(vId),
      );
    });
  }

  FutureOr<void> _verifyPhone(
      VerifyPhoneEvent event, Emitter<PhoneVerificationState> emit) async {
    emit(PhoneVerificationLoading());
    final Either<Failure, Unit> result = await verifyPhoneUseCase(event.params);

    result.fold((failure) {
      emit(PhoneVerificationError(
        message: failure.message,
        errorType: ErrorType.normal,
      ));
    }, (_) {
      emit(const PhoneVerificationSuccess());
    });
  }
}
