import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/core/utils/parameters.dart';
import 'package:fruit_market/features/auth/domain/entities/user.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';

class SignUpUseCase extends ParameterUseCase<User, SignUpParams> {
  final BaseAuthRepository repository;

  SignUpUseCase(this.repository);
  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.signup(
      params
    );
  }

  @override
  List<Object?> get props => [repository];
}
