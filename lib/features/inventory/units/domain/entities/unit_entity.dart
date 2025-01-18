import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/units/data/models/unit_model.dart';

class UnitEntity extends Equatable {
  final int? id;
  final String arName;
  final String enName;

  const UnitEntity({this.id, required this.arName, required this.enName});

  UnitModel toModel() {
    return UnitModel(id: id, arName: arName, enName: enName);
  }

  @override
  List<Object?> get props => [id, arName, enName];
}
