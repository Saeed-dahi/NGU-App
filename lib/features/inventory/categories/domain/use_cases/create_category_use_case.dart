import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/categories/domain/entities/category_entity.dart';
import 'package:ngu_app/features/inventory/categories/domain/repositories/category_repository.dart';

class CreateCategoryUseCase {
  final CategoryRepository categoryRepository;

  CreateCategoryUseCase({required this.categoryRepository});

  Future<Either<Failure, Unit>> call(CategoryEntity category) async {
    return await categoryRepository.createCategory(category);
  }
}
