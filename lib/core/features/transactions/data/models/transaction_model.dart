import 'package:ngu_app/core/features/transactions/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel(
      {super.id,
      required super.accountName,
      required super.accountCode,
      required super.type,
      required super.amount,
      required super.description,
      required super.documentNumber,
      super.accountNewBalance,
      super.date,
      super.createdAt,
      super.updatedAt});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      accountName: json['account_name'],
      accountCode: json['account_code'],
      type: json['type'],
      amount: double.parse(json['amount'].toString()),
      description: json['description'] ?? '',
      documentNumber: json['document_number'] ?? '',
      accountNewBalance: double.parse(json['account_new_balance'].toString()),
      date: json['date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_id': accountCode,
      'type': type,
      'amount': amount.toString(),
      'description': description,
      'document_number': documentNumber,
    };
  }
}
