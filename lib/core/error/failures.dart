import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/app_stings.dart';

abstract class Failure extends Equatable {
  final Map<String, dynamic> errors;

  const Failure({required this.errors});
}

class ServerFailure extends Failure {
  ServerFailure({Map<String, String>? errors})
      : super(errors: errors ?? {'error': AppStings.unKnown});

  @override
  List<Object?> get props => [errors];
}

class OfflineFailure extends Failure {
  OfflineFailure({Map<String, String>? errors})
      : super(errors: errors ?? {'error': AppStings.noInternetConnection});

  @override
  List<Object?> get props => [errors];
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.errors});

  @override
  List<Object?> get props => [errors];
}
