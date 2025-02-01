import 'package:equatable/equatable.dart';

class InvoiceAccountEntity extends Equatable {
  int id;
  final String code;
  final String arName;
  final String enName;

  InvoiceAccountEntity(
      {required this.id,
      required this.code,
      required this.arName,
      required this.enName});

  @override
  List<Object?> get props => [
        id,
        code,
        arName,
        enName,
      ];
}
