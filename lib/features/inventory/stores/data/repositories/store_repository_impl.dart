import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/inventory/stores/data/data_sources/store_data_source.dart';
import 'package:ngu_app/features/inventory/stores/domain/entities/store_entity.dart';
import 'package:ngu_app/features/inventory/stores/domain/repositories/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreDataSource storeDataSource;
  final ApiHelper apiHelper;

  StoreRepositoryImpl({required this.storeDataSource, required this.apiHelper});
  @override
  Future<Either<Failure, Unit>> createStore(StoreEntity store) async {
    return await apiHelper
        .safeApiCall(() => storeDataSource.createStore(store.toModel()));
  }

  @override
  Future<Either<Failure, List<StoreEntity>>> getStores() async {
    return await apiHelper.safeApiCall(() => storeDataSource.getStores());
  }

  @override
  Future<Either<Failure, Unit>> updateStore(StoreEntity store) async {
    return await apiHelper
        .safeApiCall(() => storeDataSource.updateStore(store.toModel()));
  }
}
