import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/categories/data/models/category_model.dart';

class CategoryEntity extends Equatable {
  final int? id;
  final String arName;
  final String enName;
  final String description;

  const CategoryEntity(
      {this.id,
      required this.arName,
      required this.enName,
      required this.description});

  CategoryModel toModel() {
    return CategoryModel(
        id: id, arName: arName, enName: enName, description: description);
  }

  @override
  List<Object?> get props => [id, arName, enName, description];
}
