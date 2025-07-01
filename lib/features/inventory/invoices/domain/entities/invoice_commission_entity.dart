import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/invoice_commission_model.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';

class InvoiceCommissionEntity extends Equatable {
  final InvoiceAccountEntity agentAccount;
  final InvoiceAccountEntity commissionAccount;
  final String type;
  final double rate;
  final double amount;

  const InvoiceCommissionEntity(
      {required this.agentAccount,
      required this.commissionAccount,
      required this.type,
      required this.rate,
      required this.amount});

  InvoiceCommissionModel toModel() {
    return InvoiceCommissionModel(
      agentAccount: agentAccount,
      commissionAccount: commissionAccount,
      type: type,
      rate: rate,
      amount: amount,
    );
  }

  @override
  List<Object?> get props =>
      [agentAccount, commissionAccount, type, rate, amount];
}
