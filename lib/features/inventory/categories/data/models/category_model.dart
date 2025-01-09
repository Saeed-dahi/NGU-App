import 'package:ngu_app/features/inventory/categories/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel(
      {super.id,
      required super.arName,
      required super.enName,
      required super.description});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'] ?? 0,
        arName: json['ar_name'] ?? '',
        enName: json['en_name'] ?? '',
        description: json['description'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'ar_name': arName, 'en_name': enName, 'description': description};
  }
}
