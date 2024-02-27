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
}
