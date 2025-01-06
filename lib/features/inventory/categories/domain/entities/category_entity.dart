import 'package:equatable/equatable.dart';

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

  @override
  List<Object?> get props => [id, arName, enName, description];
}
