import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/auth/domain/entities/user.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';

class LoginUseCase extends ParameterUseCase<User, LoginParams> {
  final BaseAuthRepository repository;
  final LoginParams params;

  LoginUseCase(this.repository, this.params);
  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(
        email: params.email, password: params.password);
  }

  @override
  List<Object?> get props => [repository, params];
}

class LoginParams {
  final String email, password;

  const LoginParams(this.email, this.password);
}
