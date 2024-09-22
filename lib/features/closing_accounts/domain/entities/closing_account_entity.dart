import 'package:equatable/equatable.dart';

class ClosingAccountEntity extends Equatable {
  final int id;
  final String arName;
  final String enName;
  final String createdAt;
  final String updatedAt;

  const ClosingAccountEntity(
      {required this.id,
      required this.arName,
      required this.enName,
      required this.createdAt,
      required this.updatedAt});

  @override
  List<Object?> get props => [id, arName, enName, createdAt, updatedAt];
}
