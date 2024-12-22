import 'package:equatable/equatable.dart';

class CustomAccountEntity extends Equatable {
  final int id;
  final String code;
  final String arName;
  final String enName;
  final double balance;

  const CustomAccountEntity(
      {required this.id,
      required this.code,
      required this.arName,
      required this.enName,
      required this.balance});

  @override
  List<Object?> get props => [id, code, arName, enName, balance];
}
