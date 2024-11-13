import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final int? id;
  final String accountName;
  final String accountCode;
  final String type;
  final double amount;
  final String description;
  final String documentNumber;
  final double? accountNewBalance;
  final String? createdAt;
  final String? updatedAt;

  const TransactionEntity(
      {this.id,
      required this.accountName,
      required this.accountCode,
      required this.type,
      required this.amount,
      required this.description,
      required this.documentNumber,
      this.accountNewBalance,
      this.createdAt,
      this.updatedAt});

  @override
  List<Object?> get props => [
        id,
        accountName,
        type,
        amount,
        description,
        documentNumber,
        accountNewBalance
      ];
}
