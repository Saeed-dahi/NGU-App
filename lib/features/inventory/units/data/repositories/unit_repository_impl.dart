import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/inventory/units/data/data_sources/unit_data_source.dart';
import 'package:ngu_app/features/inventory/units/data/models/unit_model.dart';
import 'package:ngu_app/features/inventory/units/domain/entities/unit_entity.dart';
import 'package:ngu_app/features/inventory/units/domain/repositories/unit_repository.dart';

class UnitRepositoryImpl implements UnitRepository {
  final UnitDataSource unitDataSource;
  final ApiHelper apiHelper;

  UnitRepositoryImpl({required this.unitDataSource, required this.apiHelper});

  @override
  Future<Either<Failure, Unit>> createUnit(UnitEntity unitEntity) async {
    return await apiHelper
        .safeApiCall(() => unitDataSource.createUnit(getUnitModel(unitEntity)));
  }

  @override
  Future<Either<Failure, List<UnitEntity>>> getUnits() async {
    return await apiHelper.safeApiCall(() => unitDataSource.getUnits());
  }

  @override
  Future<Either<Failure, Unit>> updateUnit(UnitEntity unitEntity) async {
    return await apiHelper
        .safeApiCall(() => unitDataSource.updateUnit(getUnitModel(unitEntity)));
  }

  UnitModel getUnitModel(UnitEntity unitEntity) {
    return UnitModel(
        id: unitEntity.id,
        arName: unitEntity.arName,
        enName: unitEntity.enName);
  }
}
