import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_unit_entity.dart';
import 'package:ngu_app/features/inventory/products/domain/repositories/product_repository.dart';

class CreateProductUnitUseCase {
  final ProductRepository productRepository;

  CreateProductUnitUseCase({required this.productRepository});

  Future<Either<Failure, Unit>> call(
      ProductUnitEntity productUnitEntity, int? baseUnitId) async {
    return await productRepository.createProductUnit(
        productUnitEntity, baseUnitId);
  }
}
