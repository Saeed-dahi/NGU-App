class ServerException implements Exception {}

class OfflineException implements Exception {}

class ValidationException implements Exception {
  final Map<String, dynamic> errors;

  ValidationException({required this.errors});
}
