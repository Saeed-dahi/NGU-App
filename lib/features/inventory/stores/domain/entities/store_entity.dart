import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/stores/data/models/store_model.dart';

class StoreEntity extends Equatable {
  final int? id;
  final String arName;
  final String enName;
  final String description;

  const StoreEntity({
    this.id,
    required this.arName,
    required this.enName,
    required this.description,
  });

  StoreModel toModel() {
    return StoreModel(
      id: id,
      arName: arName,
      enName: enName,
      description: description,
    );
  }

  @override
  List<Object?> get props => [id, arName, enName, description];
}
