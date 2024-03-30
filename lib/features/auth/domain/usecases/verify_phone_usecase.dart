import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/core/utils/partameters.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';

class VerifyPhoneUseCase extends ParameterUseCase<Unit, VerifyPhoneParams> {
  final BaseAuthRepository repository;

  VerifyPhoneUseCase(this.repository);
  @override
  Future<Either<Failure, Unit>> call(VerifyPhoneParams params) async {
    return await repository.verifyPhoneOTP(params);
  }

  @override
  List<Object?> get props => [repository];
}
