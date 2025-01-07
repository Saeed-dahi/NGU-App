import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_entity.dart';
import 'package:ngu_app/features/inventory/products/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository productRepository;

  GetProductsUseCase({required this.productRepository});

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await productRepository.getProducts();
  }
}
