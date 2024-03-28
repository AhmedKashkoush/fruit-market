import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/utils/enums.dart';
import 'package:fruit_market/features/auth/domain/usecases/send_phone_verification_usecase.dart';

part 'phone_input_event.dart';
part 'phone_input_state.dart';

class PhoneInputBloc extends Bloc<PhoneInputEvent, PhoneInputState> {
  final SendPhoneVerificationUseCase sendPhoneVerificationUseCase;
  PhoneInputBloc(this.sendPhoneVerificationUseCase)
      : super(PhoneInputInitial()) {
    on<PhoneInputSendOTPEvent>(_onPhoneInputSendOTP);
  }

  FutureOr<void> _onPhoneInputSendOTP(
      PhoneInputSendOTPEvent event, Emitter<PhoneInputState> emit) async {
    emit(PhoneInputLoadingState());

    final Either<Failure, String> result =
        await sendPhoneVerificationUseCase(event.phoneNumber);

    result.fold((failure) {
      emit(
        PhoneInputErrorState(
          message: failure.message,
          errorType: ErrorType.normal,
        ),
      );
    }, (vId) {
      emit(
        PhoneInputSuccessState(vId: vId),
      );
    });
  }
}
