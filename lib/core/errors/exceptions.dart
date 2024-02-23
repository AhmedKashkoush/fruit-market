class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
}

class ConnectionException implements Exception {
  final String message;
  const ConnectionException(this.message);
}

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}
