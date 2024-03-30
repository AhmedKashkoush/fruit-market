import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/utils/partameters.dart';
import 'package:fruit_market/features/auth/domain/entities/user.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, User>> login(LoginParams params);
  Future<Either<Failure, User>> signup(SignUpParams params);

  Future<Either<Failure, User>> signInWithGoogle();
  Future<Either<Failure, User>> signInWithFacebook();
  
  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> sendPasswordResetEmail(String email);
  Future<Either<Failure, Unit>> sendEmailVerification(LoginParams params);
  Future<Either<Failure, String>> sendOTP(String phone);
  Future<Either<Failure, Unit>> verifyPhoneOTP(VerifyPhoneParams params);
  Future<Either<Failure, Unit>> verifyEmailOTP(String otp);
  Future<Either<Failure, Unit>> updatePassword(LoginParams params);

  Future<Either<Failure, Unit>> uploadPhoto(File photo);
}
