import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';

class SendPhoneVerificationUseCase extends ParameterUseCase<String, String> {
  final BaseAuthRepository repository;

  SendPhoneVerificationUseCase(this.repository);
  @override
  Future<Either<Failure, String>> call(String params) async {
    return await repository.sendOTP(params);
  }

  @override
  List<Object?> get props => [repository];
}
