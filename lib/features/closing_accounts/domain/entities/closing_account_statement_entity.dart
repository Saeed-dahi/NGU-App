import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/custom_account_entity.dart';

class ClosingAccountStatementEntity extends Equatable {
  final List<CustomAccountEntity> revenueAccounts;
  final List<CustomAccountEntity> expenseAccounts;
  final double revenueValue;
  final double expenseValue;
  final double value;

  const ClosingAccountStatementEntity(
      {required this.revenueAccounts,
      required this.expenseAccounts,
      required this.revenueValue,
      required this.expenseValue,
      required this.value});

  @override
  List<Object?> get props =>
      [revenueAccounts, expenseAccounts, revenueValue, expenseValue, value];
}
