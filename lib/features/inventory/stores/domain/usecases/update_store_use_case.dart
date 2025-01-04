import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/stores/domain/entities/store_entity.dart';
import 'package:ngu_app/features/inventory/stores/domain/repositories/store_repository.dart';

class UpdateStoreUseCase {
  final StoreRepository storeRepository;

  UpdateStoreUseCase({required this.storeRepository});
  Future<Either<Failure, Unit>> call(StoreEntity store) async {
    return await storeRepository.updateStore(store);
  }
}
