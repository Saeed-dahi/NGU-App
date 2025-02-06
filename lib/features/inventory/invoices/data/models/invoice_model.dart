import 'package:ngu_app/features/inventory/invoices/data/models/invoice_account_model.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/invoice_item_model.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel(
      {super.id,
      super.invoiceNumber,
      super.invoiceType,
      super.date,
      super.dueDate,
      super.status,
      super.invoiceNature,
      super.currency,
      super.subTotal,
      super.total,
      super.notes,
      super.account,
      super.goodsAccount,
      super.taxAccount,
      super.totalTax,
      super.discountAccount,
      super.totalDiscount,
      super.invoiceItems});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json['id'],
      invoiceNumber: json['invoice_number'],
      invoiceType: json['type'] ?? '',
      date: json['date'] ?? '',
      dueDate: json['due_date'] ?? '',
      status: json['status'] ?? '',
      invoiceNature: json['invoice_nature'],
      currency: json['currency'] ?? '',
      subTotal: double.tryParse(json['sub_total'].toString()),
      total: double.tryParse(json['total'].toString()),
      notes: json['notes'] ?? '',
      account: InvoiceAccountModel.fromJson(json['account']),
      goodsAccount: InvoiceAccountModel.fromJson(json['goods_account']),
      taxAccount: InvoiceAccountModel.fromJson(json['tax_account']),
      totalTax: double.tryParse(json['total_tax'].toString()),
      discountAccount: InvoiceAccountModel.fromJson(json['discount_account']),
      totalDiscount: double.tryParse(json['total_discount'].toString()),
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
      'type': invoiceType,
      'date': date,
      'due_date': dueDate,
      'status': status,
      'invoice_nature': invoiceNature,
      'currency': 'AED',
      'notes': notes,
      'account_id': account!.id,
      'goods_account_id': goodsAccount!.id,
      'total_tax_account': taxAccount!.id,
      'total_discount_account': discountAccount!.id
    };
  }
}
