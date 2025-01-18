import 'package:equatable/equatable.dart';
import 'package:ngu_app/core/features/transactions/data/models/transaction_model.dart';

class TransactionEntity extends Equatable {
  final int? id;
  final String accountName;
  final String accountCode;
  final int accountId;
  final String type;
  final double amount;
  final String description;
  final String documentNumber;
  final String? date;
  final double? accountNewBalance;
  final String? createdAt;
  final String? updatedAt;

  const TransactionEntity(
      {this.id,
      required this.accountName,
      required this.accountCode,
      required this.accountId,
      required this.type,
      required this.amount,
      required this.description,
      required this.documentNumber,
      this.date,
      this.accountNewBalance,
      this.createdAt,
      this.updatedAt});

  TransactionModel toModel() {
    return TransactionModel(
      type: type,
      accountName: accountName,
      accountCode: accountCode,
      accountId: accountId,
      amount: amount,
      description: description,
      documentNumber: documentNumber,
    );
  }

  @override
  List<Object?> get props => [
        id,
        accountName,
        type,
        amount,
        date,
        description,
        documentNumber,
        accountNewBalance,
        createdAt,
        updatedAt
      ];
}
