import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/error/exception.dart';

class ErrorHandler extends Equatable {
  static handleResponse(int statusCode, dynamic decodedJson) {
    switch (statusCode) {
      case ResponseCode.success:
        break;
      case ResponseCode.errorValidation:
        throw ValidationException(errors: decodedJson['errors']);
      case ResponseCode.badRequest:
        throw ServerException(
            error: decodedJson['message'] ?? AppStrings.badRequest.tr);
      case ResponseCode.unAuthorized:
        throw ServerException(error: AppStrings.unAuthorized.tr);
      case ResponseCode.forbidden:
        throw ServerException(error: AppStrings.forbidden.tr);
      case ResponseCode.notFound:
        throw ServerException(error: AppStrings.notFound.tr);
      case ResponseCode.internalServerError:
        throw ServerException(error: AppStrings.internalServerError.tr);
      case ResponseCode.unKnown:
        throw ServerException(error: AppStrings.unKnown.tr);
      case ResponseCode.connectionTimeout:
        throw ServerException(error: AppStrings.connectionTimeout.tr);
      case ResponseCode.receiveTimeout:
        throw ServerException(error: AppStrings.receiveTimeout.tr);
      case ResponseCode.cancel:
        throw ServerException(error: AppStrings.cancel.tr);
      case ResponseCode.cacheError:
        throw ServerException(error: AppStrings.cacheError.tr);
      case ResponseCode.noInternetConnection:
        throw ServerException(error: AppStrings.noInternetConnection.tr);
      default:
        throw Exception(AppStrings.unKnown.tr);
    }
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ResponseCode {
  static const success = 200;
  static const noContent = 201;
  static const badRequest = 400;
  static const unAuthorized = 401;
  static const forbidden = 403;
  static const notFound = 404;
  static const errorValidation = 422;
  static const badCertificate = 495;
  static const internalServerError = 500;
  static const connectionError = 502;
  static const connectionTimeout = 599;
  static const receiveTimeout = 408;
  static const sendTimeout = 408;
  static const cancel = -1;
  static const cacheError = -2;
  static const noInternetConnection = -3;
  static const unKnown = -4;
}

class ResponseMessage {
  static String success = AppStrings.success;
  static String noContent = AppStrings.noContent;
  static String badRequest = AppStrings.badRequest;
  static String unAuthorized = AppStrings.unAuthorized;
  static String forbidden = AppStrings.forbidden;
  static String notFound = AppStrings.notFound;
  static String internalServerError = AppStrings.internalServerError;
  static String connectionTimeout = AppStrings.connectionTimeout;
  static String cancel = AppStrings.cancel;
  static String receiveTimeout = AppStrings.receiveTimeout;
  static String sendTimeout = AppStrings.sendTimeout;
  static String cacheError = AppStrings.cacheError;
  static String noInternetConnection = AppStrings.noInternetConnection;
  static String unKnown = AppStrings.unKnown;
}
