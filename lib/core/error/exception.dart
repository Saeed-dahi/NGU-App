import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';

class ServerException implements Exception {
  final String error;

  ServerException({String? error})
      : error = error ?? AppStrings.internalServerError.tr;
}

class OfflineException implements Exception {}

class ValidationException implements Exception {
  final Map<String, dynamic> errors;

  ValidationException({required this.errors});
}
