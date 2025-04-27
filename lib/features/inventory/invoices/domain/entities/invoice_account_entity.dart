import 'package:equatable/equatable.dart';

class InvoiceAccountEntity extends Equatable {
  int? id;
  String? code;
  String? arName;
  String? enName;
  String? description;
  get getId => id;

  set setId(id) => this.id = id;

  get getCode => code;

  set setCode(code) => this.code = code;

  get getArName => arName;

  set setArName(arName) => this.arName = arName;

  get getEnName => enName;

  set setEnName(enName) => this.enName = enName;

  get getDescription => description;

  set setDescription(description) => this.description = description;

  InvoiceAccountEntity(
      {this.id, this.code, this.arName, this.enName, this.description});

  InvoiceAccountEntity copyWith(
      {int? id,
      String? code,
      String? arName,
      String? enName,
      String? description}) {
    return InvoiceAccountEntity(
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
