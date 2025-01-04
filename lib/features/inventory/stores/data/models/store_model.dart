import 'package:ngu_app/features/inventory/stores/domain/entities/store_entity.dart';

class StoreModel extends StoreEntity {
  const StoreModel(
      {required super.id,
      required super.arName,
      required super.enName,
      required super.description});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
        id: json['id'],
        arName: json['ar_name'],
        enName: json['en_name'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {'ar_name': arName, 'en_name': enName, 'description': description};
  }
}
