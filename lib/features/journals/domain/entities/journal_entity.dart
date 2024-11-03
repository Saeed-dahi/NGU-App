import 'package:equatable/equatable.dart';
import 'package:ngu_app/core/features/transactions/domain/entities/transaction_entity.dart';

class JournalEntity extends Equatable {
  final int? id;
  final String document;
  final String description;
  final String status;
  final String createdAt;
  final String? updatedAt;
  final List<TransactionEntity> transactions;

  const JournalEntity(
      {this.id,
      required this.document,
      required this.description,
      required this.status,
      required this.transactions,
      required this.createdAt,
      this.updatedAt});

  @override
  List<Object?> get props =>
      [id, document, description, status, createdAt, updatedAt, transactions];
}
