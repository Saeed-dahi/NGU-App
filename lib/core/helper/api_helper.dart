import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/exception.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/network/network_info.dart';

class ApiHelper {
  final NetworkInfo networkInfo;

  ApiHelper({required this.networkInfo});

  Future<Either<Failure, T>> safeApiCall<T>(
      Future<T> Function() apiCall) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await apiCall();
        return right(result);
      } on ServerException catch (message) {
        return left(ServerFailure(errors: {'error': message.error}));
      } on ValidationException catch (messages) {
        return left(ValidationFailure(errors: messages.errors));
      } catch (e) {
        return left(ServerFailure(errors: {'error': e.toString()}));
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
