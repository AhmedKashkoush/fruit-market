import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message});
}

class VerificationFailure extends Failure {
  const VerificationFailure({required super.message});
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({required super.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}
