import 'package:ngu_app/core/features/transactions/data/models/transaction_model.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';

class JournalModel extends JournalEntity {
  const JournalModel(
      {super.id,
      required super.document,
      required super.description,
      required super.status,
      required super.transactions,
      required super.createdAt,
      super.updatedAt});

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
        id: json['id'],
        document: json['document'] ?? '',
        description: json['description'] ?? '',
        status: json['status'],
        transactions:
            json['transactions'].map<TransactionModel>((transactions) {
          return TransactionModel.fromJson(transactions);
        }).toList(),
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'document': document,
      'description': description,
      'status': status,
      'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    };
  }
}
