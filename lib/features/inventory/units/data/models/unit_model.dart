import 'package:ngu_app/features/inventory/units/domain/entities/unit_entity.dart';

class UnitModel extends UnitEntity {
  const UnitModel({super.id, required super.arName, required super.enName});

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
        id: json['id'], arName: json['ar_name'], enName: json['en_name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'ar_name': arName, 'en_name': enName};
  }
}
