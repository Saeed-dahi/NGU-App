import 'package:dartz/dartz.dart';

import 'package:ngu_app/core/error/failures.dart';

class DataBaseHelper {
  Future<Either<Failure, T>> safeDataBaseConnection<T>(
      Future<T> Function() dataBaseConnect) async {
    try {
      final result = await dataBaseConnect();
      return right(result);
    } catch (e) {
      return Left(DatabaseFailure(errors: {'error': e.toString()}));
    }
  }
}
