import 'package:ngu_app/core/features/transactions/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel(
      {required super.id,
      required super.accountName,
      required super.type,
      required super.amount,
      required super.description,
      required super.documentNumber,
      required super.accountNewBalance,
      required super.createdAt,
      required super.updatedAt});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      accountName: json['account_name'],
      type: json['type'],
      amount: double.parse(json['amount'].toString()),
      description: json['description'] ?? '',
      documentNumber: json['document_number'] ?? '',
      accountNewBalance: json['account_new_balance'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'account_name': accountName,
      'type': type,
      'amount': amount.toString(),
      'description': description,
      'document_number': documentNumber,
      'account_new_balance': accountNewBalance,
    };
  }
}
