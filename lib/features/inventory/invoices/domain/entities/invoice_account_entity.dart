import 'package:equatable/equatable.dart';

class InvoiceAccountEntity extends Equatable {
  int? id;
  final String? code;
  final String? arName;
  final String? enName;
  final String? description;

  InvoiceAccountEntity(
      {this.id, this.code, this.arName, this.enName, this.description});

  @override
  List<Object?> get props => [id, code, arName, enName, description];
}
