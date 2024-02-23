import 'package:fruit_market/features/auth/data/models/user_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<UserModel> signup({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String address,
    String phone = '',
    String imgUrl = '',
    DateTime? birthday,
  });

  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithFacebook();
  Future<UserModel> logout();
}

class AuthRemoteDataSource implements BaseAuthRemoteDataSource {
  @override
  Future<UserModel> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<UserModel> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signup(
      {required String name,
      required String email,
      required String password,
      required String gender,
      required String address,
      String phone = '',
      String imgUrl = '',
      DateTime? birthday}) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
