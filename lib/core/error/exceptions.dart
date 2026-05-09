sealed class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException({required this.message, this.statusCode});
  @override
  String toString() => "ApiException: $message(statusCode:$statusCode)";
}

class EmptyException extends ApiException {
  const EmptyException() : super(message: '');
}

class ServerException extends ApiException {
  const ServerException({
    super.message = 'Server error occurred',
    super.statusCode,
  });
}

class NetworkException extends ApiException {
  const NetworkException({super.message = 'Network error occurred'});
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({
    super.message = 'Unauthorized access',
    super.statusCode = 401,
  });
}

class BadRequestException extends ApiException {
  const BadRequestException({
    super.message = 'Invalid request',
    super.statusCode = 400,
  });
}
