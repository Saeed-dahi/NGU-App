import 'package:ngu_app/features/inventory/invoices/data/models/invoice_account_model.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_commission_entity.dart';

class InvoiceCommissionModel extends InvoiceCommissionEntity {
  const InvoiceCommissionModel(
      {required super.agentAccount,
      required super.commissionAccount,
      required super.type,
      required super.rate,
      required super.amount});

  factory InvoiceCommissionModel.fromJson(Map<String, dynamic> json) {
    return InvoiceCommissionModel(
      agentAccount: InvoiceAccountModel.fromJson(json['agent_account']),
      commissionAccount:
          InvoiceAccountModel.fromJson(json['commission_account']),
      type: json['commission_type'],
      rate: double.tryParse(json['commission_rate'].toString()) ?? 0.0,
      amount: double.tryParse(json['commission_amount'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'agent_id': agentAccount.id,
      'commission_account_id': commissionAccount.id,
      'commission_type': type,
      'commission_rate': rate,
    };
  }
}
