import 'package:equatable/equatable.dart';

class InvoiceAccountEntity extends Equatable {
  int? id;
  final String? code;
  final String? arName;
  final String? enName;
  final String? description;

  InvoiceAccountEntity(
      {this.id, this.code, this.arName, this.enName, this.description});

  InvoiceAccountEntity copyWith(
      {int? id,
      String? code,
      String? arName,
      String? enName,
      String? description}) {
    return InvoiceAccountEntity(
        id: id,
        arName: arName,
        enName: enName,
        code: code,
        description: description);
  }

  @override
  List<Object?> get props => [id, code, arName, enName, description];
}
