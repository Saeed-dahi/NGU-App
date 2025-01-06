import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/inventory/categories/data/data_sources/category_data_source.dart';
import 'package:ngu_app/features/inventory/categories/data/models/category_model.dart';
import 'package:ngu_app/features/inventory/categories/domain/entities/category_entity.dart';
import 'package:ngu_app/features/inventory/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final ApiHelper apiHelper;
  final CategoryDataSource categoryDataSource;

  CategoryRepositoryImpl(
      {required this.apiHelper, required this.categoryDataSource});

  @override
  Future<Either<Failure, Unit>> createCategory(CategoryEntity category) async {
    return await apiHelper.safeApiCall(
        () => categoryDataSource.createCategory(getCategoryModel(category)));
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    return await apiHelper
        .safeApiCall(() => categoryDataSource.getCategories());
  }

  @override
  Future<Either<Failure, Unit>> updateCategory(CategoryEntity category) async {
    return await apiHelper.safeApiCall(
        () => categoryDataSource.updateCategory(getCategoryModel(category)));
  }

  CategoryModel getCategoryModel(CategoryEntity category) {
    return CategoryModel(
        id: category.id,
        arName: category.arName,
        enName: category.enName,
        description: category.description);
  }
}
