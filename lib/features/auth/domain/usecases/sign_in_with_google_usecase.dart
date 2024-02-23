import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/auth/domain/entities/user.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';

class SignInWithGoogleUseCase extends NoParameterUseCase<User> {
  final BaseAuthRepository repository;

  SignInWithGoogleUseCase(this.repository);
  @override
  Future<Either<Failure, User>> call() async {
    return await repository.signInWithGoogle();
  }

  @override
  List<Object?> get props => [repository];
}
