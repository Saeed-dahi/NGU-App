import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';

class InvoiceAccountModel extends InvoiceAccountEntity {
  InvoiceAccountModel(
      {super.id, super.code, super.arName, super.enName, super.description});

  factory InvoiceAccountModel.fromJson(Map<String, dynamic>? json) {
    return InvoiceAccountModel(
        id: json?['id'],
        code: json?['code'],
        arName: json?['ar_name'],
        enName: json?['en_name'],
        description: json?['description']);
  }
}
