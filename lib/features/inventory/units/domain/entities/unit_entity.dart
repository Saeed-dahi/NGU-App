import 'package:equatable/equatable.dart';

class UnitEntity extends Equatable {
  final int? id;
  final String arName;
  final String enName;

  const UnitEntity({this.id, required this.arName, required this.enName});

  @override
  List<Object?> get props => [id, arName, enName];
}
