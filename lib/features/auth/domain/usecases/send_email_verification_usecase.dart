import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/core/utils/partameters.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';

class SendEmailVerificationUseCase extends ParameterUseCase<Unit, LoginParams> {
  final BaseAuthRepository repository;

  SendEmailVerificationUseCase(this.repository);
  @override
  Future<Either<Failure, Unit>> call(LoginParams params) async {
    return await repository.sendEmailVerification(params);
  }

  @override
  List<Object?> get props => [repository];
}
