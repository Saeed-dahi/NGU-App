import 'package:ngu_app/features/closing_accounts/data/models/custom_account_model.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_statement_entity.dart';

class ClosingAccountStatementModel extends ClosingAccountStatementEntity {
  const ClosingAccountStatementModel(
      {required super.revenueAccounts,
      required super.expenseAccounts,
      required super.revenueValue,
      required super.expenseValue,
      required super.value});

  factory ClosingAccountStatementModel.fromJson(Map<String, dynamic> json) {
    return ClosingAccountStatementModel(
      revenueAccounts: json['revenue_accounts']
              ?.map<CustomAccountModel>(
                  (account) => CustomAccountModel.fromJson(account))
              .toList() ??
          [],
      expenseAccounts: json['expense_accounts']
              ?.map<CustomAccountModel>(
                  (account) => CustomAccountModel.fromJson(account))
              .toList() ??
          [],
      revenueValue: double.parse(json['revenue'].toString()),
      expenseValue: double.parse(json['expense'].toString()),
      value: double.parse(json['value'].toString()),
    );
  }
}
