import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';

class SendPasswordResetEmailUseCase extends ParameterUseCase<Unit, String> {
  final BaseAuthRepository repository;

  SendPasswordResetEmailUseCase(this.repository);
  @override
  Future<Either<Failure, Unit>> call(String params) async {
    return await repository.sendPasswordResetEmail(params);
  }

  @override
  List<Object?> get props => [repository];
}
