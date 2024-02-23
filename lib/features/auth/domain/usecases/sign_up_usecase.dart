import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/failures.dart';
import 'package:fruit_market/core/usecases/base_usecases.dart';
import 'package:fruit_market/features/auth/domain/entities/user.dart';
import 'package:fruit_market/features/auth/domain/repositories/base_auth_repository.dart';

class LoginUseCase extends ParameterUseCase<User, SignUpParams> {
  final BaseAuthRepository repository;
  final SignUpParams params;

  LoginUseCase(this.repository, this.params);
  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.signup(
      name: params.name,
      email: params.email,
      password: params.password,
      gender: params.gender,
      address: params.address,
      imgUrl: params.imgUrl,
      phone: params.phone,
      birthday: params.birthday,
    );
  }

  @override
  List<Object?> get props => [repository, params];
}

class SignUpParams {
  final String name, email, password, phone, imgUrl, gender, address;
  final DateTime? birthday;

  const SignUpParams(this.name, this.email, this.phone, this.imgUrl,
      this.gender, this.address, this.birthday, this.password);
}
