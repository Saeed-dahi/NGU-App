import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_entity.dart';
import 'package:ngu_app/features/inventory/products/domain/repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository productRepository;

  UpdateProductUseCase({required this.productRepository});

  Future<Either<Failure, Unit>> call(ProductEntity product, List<File> file,
      List<String> filesToDelete) async {
    return await productRepository.updateProducts(product, file, filesToDelete);
  }
}
