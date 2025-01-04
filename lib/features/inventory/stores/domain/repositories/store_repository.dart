import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/stores/domain/entities/store_entity.dart';

abstract class StoreRepository {
  Future<Either<Failure, List<StoreEntity>>> getStores();
  Future<Either<Failure, Unit>> createStore(StoreEntity store);
  Future<Either<Failure, Unit>> updateStore(StoreEntity store);
}
