import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/core/errors/exceptions.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/utils/parameters.dart';
import 'package:fruit_market/features/auth/data/data%20sources/remote/auth_remote_data_source.dart';
import 'package:fruit_market/features/auth/data/models/user_model.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';

class AuthRepository implements BaseAuthRepository {
  final BaseAuthRemoteDataSource remoteDataSource;

  const AuthRepository(this.remoteDataSource);
  @override
  Future<Either<Failure, UserModel>> login(LoginParams params) async {
    try {
      final UserModel user = await remoteDataSource.login(params);
      return Right(user);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message,
        ),
      );
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(
          message: e.message,
        ),
      );
    } on VerificationException catch (e) {
      return Left(
        VerificationFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return const Left(
        ServerFailure(
          message: 'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message,
        ),
      );
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return const Left(
        ServerFailure(
          message: 'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithFacebook() async {
    try {
      final UserModel user = await remoteDataSource.signInWithFacebook();
      return Right(user);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message,
        ),
      );
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return const Left(
        ServerFailure(
          message: 'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    try {
      final UserModel user = await remoteDataSource.signInWithGoogle();
      return Right(user);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message,
        ),
      );
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return const Left(
        ServerFailure(
          message: 'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel>> signup(SignUpParams params) async {
    try {
      final UserModel user = await remoteDataSource.signup(params);
      return Right(user);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message,
        ),
      );
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      return const Left(
        ServerFailure(
          message: 'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> sendOTP(String phone) async {
    try {
      final String vId = await remoteDataSource.sendOTP(phone);
      return Right(vId);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message,
        ),
      );
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(
          message: e.message,
        ),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return const Left(
        ServerFailure(
          message: 'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> sendPasswordResetEmail(String email) async {
    try {
      await remoteDataSource.sendPasswordResetEmail(email);
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message,
        ),
      );
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return const Left(
        ServerFailure(
          message: 'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(LoginParams params) async {
    try {
      await remoteDataSource.updatePassword(params);
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message,
        ),
      );
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return const Left(
        ServerFailure(
          message: 'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> uploadPhoto(File photo) async {
    try {
      await remoteDataSource.uploadPhoto(photo);
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message,
        ),
      );
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return const Left(
        ServerFailure(
          message: 'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneOTP(VerifyPhoneParams params) async {
    try {
      await remoteDataSource.verifyPhoneOTP(params);
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message,
        ),
      );
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return const Left(
        ServerFailure(
          message: 'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyEmailOTP(String otp) async {
    try {
      await remoteDataSource.verifyEmailOTP(otp);
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message,
        ),
      );
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return const Left(
        ServerFailure(
          message: 'Something went wrong',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> sendEmailVerification(
      LoginParams params) async {
    try {
      await remoteDataSource.sendEmailVerification(params);
      return const Right(unit);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message,
        ),
      );
    } on ConnectionException catch (e) {
      return Left(
        ConnectionFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return const Left(
        ServerFailure(
          message: 'Something went wrong',
        ),
      );
    }
  }
}
