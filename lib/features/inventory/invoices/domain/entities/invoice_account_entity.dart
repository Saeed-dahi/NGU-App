import 'package:equatable/equatable.dart';

class InvoiceAccountEntity extends Equatable {
  int? id;
  final String? code;
  final String? arName;
  final String? enName;

  InvoiceAccountEntity({this.id, this.code, this.arName, this.enName});

  @override
  List<Object?> get props => [
        id,
        code,
        arName,
        enName,
      ];
}
