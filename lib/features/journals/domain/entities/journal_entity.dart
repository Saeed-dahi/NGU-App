import 'package:equatable/equatable.dart';
import 'package:ngu_app/core/features/transactions/domain/entities/transaction_entity.dart';
import 'package:ngu_app/features/journals/data/models/journal_model.dart';

class JournalEntity extends Equatable {
  final int? id;
  final String document;
  final String description;
  final String status;
  final String date;
  final String? createdAt;
  final String? updatedAt;
  final List<TransactionEntity> transactions;

  const JournalEntity(
      {this.id,
      required this.document,
      required this.description,
      required this.status,
      required this.transactions,
      required this.date,
      this.createdAt,
      this.updatedAt});

  JournalModel toModel() {
    return JournalModel(
        id: id,
        document: document,
        description: description,
        status: status,
        transactions: transactions,
        date: date);
  }

  @override
  List<Object?> get props => [
        id,
        document,
        description,
        status,
        date,
        createdAt,
        updatedAt,
        transactions
      ];
}
