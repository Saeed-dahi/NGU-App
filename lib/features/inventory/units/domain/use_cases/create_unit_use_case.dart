import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/units/domain/entities/unit_entity.dart';
import 'package:ngu_app/features/inventory/units/domain/repositories/unit_repository.dart';

class CreateUnitUseCase {
  final UnitRepository unitRepository;

  CreateUnitUseCase({required this.unitRepository});

  Future<Either<Failure, Unit>> call(UnitEntity unitEntity) async {
    return await unitRepository.createUnit(unitEntity);
  }
}
