import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/inventory/units/data/data_sources/unit_data_source.dart';
import 'package:ngu_app/features/inventory/units/domain/entities/unit_entity.dart';
import 'package:ngu_app/features/inventory/units/domain/repositories/unit_repository.dart';

class UnitRepositoryImpl implements UnitRepository {
  final UnitDataSource unitDataSource;
  final ApiHelper apiHelper;

  UnitRepositoryImpl({required this.unitDataSource, required this.apiHelper});

  @override
  Future<Either<Failure, Unit>> createUnit(UnitEntity unitEntity) async {
    return await apiHelper
        .safeApiCall(() => unitDataSource.createUnit(unitEntity.toModel()));
  }

  @override
  Future<Either<Failure, List<UnitEntity>>> getUnits(int? productId) async {
    return await apiHelper
        .safeApiCall(() => unitDataSource.getUnits(productId));
  }

  @override
  Future<Either<Failure, Unit>> updateUnit(UnitEntity unitEntity) async {
    return await apiHelper
        .safeApiCall(() => unitDataSource.updateUnit(unitEntity.toModel()));
  }
}
