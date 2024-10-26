import 'package:equatable/equatable.dart';
import 'package:ngu_app/core/features/transactions/domain/entities/transaction_entity.dart';

class AccountStatementEntity extends Equatable {
  final List<TransactionEntity> transactions;
  final double debitBalance;
  final double creditBalance;

  const AccountStatementEntity(
      {required this.transactions,
      required this.debitBalance,
      required this.creditBalance});

  @override
  List<Object?> get props => [transactions, debitBalance, creditBalance];
}
