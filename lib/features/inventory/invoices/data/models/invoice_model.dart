import 'package:ngu_app/features/inventory/invoices/data/models/invoice_account_model.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/invoice_item_model.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel(
      {super.id,
      super.invoiceNumber,
      super.documentNumber,
      super.invoiceType,
      super.date,
      super.dueDate,
      super.status,
      super.invoiceNature,
      super.address,
      super.currency,
      super.subTotal,
      super.total,
      super.notes,
      super.description,
      super.account,
      super.goodsAccount,
      super.taxAccount,
      super.taxAmount,
      super.discountAccount,
      super.discountAmount,
      super.discountType,
      super.invoiceItems});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      invoiceNumber: json['invoice_number'],
      documentNumber: json['document_number'] ?? '',
      invoiceType: json['type'] ?? '',
      date: json['date'] ?? '',
      dueDate: json['due_date'] ?? '',
      status: json['status'] ?? '',
      invoiceNature: json['invoice_nature'],
      address: json['address'] ?? '',
      currency: json['currency'] ?? '',
      subTotal: double.tryParse(json['sub_total'].toString()) ?? 0,
      total: double.tryParse(json['total'].toString()),
      notes: json['notes'] ?? '',
      description: json['description'],
      account: InvoiceAccountModel.fromJson(json['account']),
      goodsAccount: InvoiceAccountModel.fromJson(json['goods_account']),
      taxAccount: InvoiceAccountModel.fromJson(json['tax_account']),
      taxAmount: double.tryParse(json['tax_amount'].toString()) ?? 0.0,
      discountAccount: InvoiceAccountModel.fromJson(json['discount_account']),
      discountAmount: double.tryParse(json['discount_amount'].toString()),
      discountType: json['discount_type'] ?? '',
      invoiceItems: json['items']
          ?.map<InvoiceItemModel>(
              (invoice) => InvoiceItemModel.fromJson(invoice))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoice_number': invoiceNumber,
      'document_number': documentNumber,
      'type': invoiceType,
      'date': date,
      'due_date': dueDate,
      'status': status,
      'invoice_nature': invoiceNature,
      'address': address,
      'currency': 'AED',
      'notes': notes,
      'description': description,
      'account_id': account!.id,
      'goods_account_id': goodsAccount!.id,
      'tax_account_id': taxAccount!.id,
      'discount_account_id': discountAccount!.id,
      'discount_amount': discountAmount,
      'discount_type': discountType
    };
  }
}
