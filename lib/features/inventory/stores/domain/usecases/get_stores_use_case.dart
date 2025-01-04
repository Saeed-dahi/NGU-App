import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/stores/domain/entities/store_entity.dart';
import 'package:ngu_app/features/inventory/stores/domain/repositories/store_repository.dart';

class GetStoresUseCase {
  final StoreRepository storeRepository;

  GetStoresUseCase({required this.storeRepository});

  Future<Either<Failure, List<StoreEntity>>> call() async {
    return await storeRepository.getStores();
  }
}
