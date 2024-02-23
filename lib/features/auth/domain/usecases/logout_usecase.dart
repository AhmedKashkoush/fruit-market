import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';

class LogoutUseCase extends NoParameterUseCase<Unit> {
  final BaseAuthRepository repository;

  LogoutUseCase(this.repository);
  @override
  Future<Either<Failure, Unit>> call() async {
    return await repository.logout();
  }

  @override
  List<Object?> get props => [repository];
}
