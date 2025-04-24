import 'package:equatable/equatable.dart';

class ChequeAccountEntity extends Equatable {
  int? id;
  final String? code;
  final String? arName;
  final String? enName;
  final String? description;

  ChequeAccountEntity(
      {this.id, this.code, this.arName, this.enName, this.description});

  ChequeAccountEntity copyWith(
      {int? id,
      String? code,
      String? arName,
      String? enName,
      String? description}) {
    return ChequeAccountEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      arName: arName ?? this.arName,
      enName: enName ?? this.enName,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [id, code, arName, enName, description];
}
