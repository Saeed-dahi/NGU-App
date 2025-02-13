import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/units/domain/entities/unit_entity.dart';
import 'package:ngu_app/features/inventory/units/domain/repositories/unit_repository.dart';

class GetUnitsUseCase {
  final UnitRepository unitRepository;

  GetUnitsUseCase({required this.unitRepository});

  Future<Either<Failure, List<UnitEntity>>> call({int? productId,bool? showProductUnits}) async {
    return await unitRepository.getUnits(productId,showProductUnits);
  }
}
