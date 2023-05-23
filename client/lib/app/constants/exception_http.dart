 class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);

  @override
  String toString() => 'TimeoutException: $message';
}

class NoInternetException implements Exception {
  final String message;

  NoInternetException(this.message);

  @override
  String toString() => 'NoInternetException: $message';
}

class InvalidDataException implements Exception {
  final String message;

  InvalidDataException(this.message);

  @override
  String toString() => 'InvalidDataException: $message';
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}
class BadRequestException implements Exception {
  final String message;

  BadRequestException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}