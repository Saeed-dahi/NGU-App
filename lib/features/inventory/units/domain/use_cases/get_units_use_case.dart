import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/units/domain/entities/unit_entity.dart';
import 'package:ngu_app/features/inventory/units/domain/repositories/unit_repository.dart';

class GetEntitiesUseCase {
  final UnitRepository unitRepository;

  GetEntitiesUseCase({required this.unitRepository});

  Future<Either<Failure, List<UnitEntity>>> call() async {
    return await unitRepository.getUnits();
  }
}
