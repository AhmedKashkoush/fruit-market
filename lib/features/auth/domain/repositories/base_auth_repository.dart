import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/features/auth/domain/entities/user.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> signup({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String address,
    String phone = '',
    String imgUrl = '',
    DateTime? birthday,
  });

  Future<Either<Failure, User>> signInWithGoogle();
  Future<Either<Failure, User>> signInWithFacebook();
  Future<Either<Failure, Unit>> logout();
}
