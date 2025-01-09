import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_entity.dart';
import 'package:ngu_app/features/inventory/products/domain/repositories/product_repository.dart';

class ShowProductUseCase {
  final ProductRepository productRepository;

  ShowProductUseCase({required this.productRepository});

  Future<Either<Failure, ProductEntity>> call(int id,String? direction) async {
    return await productRepository.showProduct(id,direction);
  }
}
