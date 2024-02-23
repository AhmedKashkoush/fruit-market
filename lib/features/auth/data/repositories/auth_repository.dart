import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/exceptions.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/features/auth/data/data%20sources/remote/auth_remote_data_source.dart';
import 'package:fruit_market/features/auth/data/models/user_model.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';

class AuthRepository implements BaseAuthRepository {
  final BaseAuthRemoteDataSource remoteDataSource;

  const AuthRepository(this.remoteDataSource);
  @override
  Future<Either<Failure, UserModel>> login(
      {required String email, required String password}) async {
    try {
      final UserModel user =
          await remoteDataSource.login(email: email, password: password);
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
      return Left(
        ServerFailure(
          message: e.toString(),
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
      return Left(
        ServerFailure(
          message: e.toString(),
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
      return Left(
        ServerFailure(
          message: e.toString(),
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
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String address,
    String phone = '',
    String imgUrl = '',
    DateTime? birthday,
  }) async {
    try {
      final UserModel user = await remoteDataSource.signup(
        name: name,
        email: email,
        password: password,
        gender: gender,
        address: address,
      );
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
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
