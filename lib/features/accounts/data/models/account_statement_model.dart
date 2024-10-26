import 'package:ngu_app/core/features/transactions/data/models/transaction_model.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_statement_entity.dart';

class AccountStatementModel extends AccountStatementEntity {
  const AccountStatementModel(
      {required super.transactions,
      required super.debitBalance,
      required super.creditBalance});

  factory AccountStatementModel.fromJson(Map<String, dynamic> json) {
    return AccountStatementModel(
        transactions: json['transactions'].map<TransactionModel>((transaction) {
          return TransactionModel.fromJson(transaction);
        }).toList(),
        debitBalance: double.parse(json['debit_balance'].toString()),
        creditBalance: double.parse(json['credit_balance'].toString()));
  }
}
