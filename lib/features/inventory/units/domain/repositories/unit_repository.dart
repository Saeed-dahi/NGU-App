import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/units/domain/entities/unit_entity.dart';

abstract class UnitRepository {
  Future<Either<Failure, List<UnitEntity>>> getUnits();
  Future<Either<Failure, Unit>> createUnit(UnitEntity unitEntity);
  Future<Either<Failure, Unit>> updateUnit(UnitEntity unitEntity);
}
