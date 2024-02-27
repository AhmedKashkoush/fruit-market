import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/core/utils/partameters.dart';
import 'package:fruit_market/features/auth/domain/entities/user.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';

class LoginUseCase extends ParameterUseCase<User, LoginParams> {
  final BaseAuthRepository repository;

  LoginUseCase(this.repository);
  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params);
  }

  @override
  List<Object?> get props => [repository];
}
