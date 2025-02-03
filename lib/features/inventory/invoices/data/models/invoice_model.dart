import 'package:ngu_app/features/inventory/invoices/data/models/invoice_account_model.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/invoice_item_model.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  const InvoiceModel(
      {required super.id,
      required super.invoiceNumber,
      required super.invoiceType,
      required super.date,
      required super.dueDate,
      required super.status,
      required super.invoiceNature,
      required super.currency,
      required super.subTotal,
      required super.total,
      required super.notes,
      required super.account,
      required super.goodsAccount,
      required super.taxAccount,
      required super.totalTax,
      required super.discountAccount,
      required super.totalDiscount,
      required super.invoiceItems});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
        id: json['id'],
        invoiceNumber: json['invoice_number'],
        invoiceType: json['type'],
        date: json['date'],
        dueDate: json['due_date'] ?? '',
        status: json['status'],
        invoiceNature: json['invoice_nature'],
        currency: json['currency'],
        subTotal: double.parse(json['sub_total'].toString()),
        total: double.parse(json['total'].toString()),
        notes: json['notes'] ?? '',
        account: InvoiceAccountModel.fromJson(json['account']),
        goodsAccount: InvoiceAccountModel.fromJson(json['goods_account']),
        taxAccount: InvoiceAccountModel.fromJson(json['tax_account']),
        totalTax: double.parse(json['total_tax'].toString()),
        discountAccount: InvoiceAccountModel.fromJson(json['discount_account']),
        totalDiscount: double.parse(json['total_discount'].toString()),
        invoiceItems: json['items']
            .map<InvoiceItemModel>(
                (invoice) => InvoiceItemModel.fromJson(invoice))
            .toList());
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
      'account_id': account.id,
      'goods_account_id': goodsAccount.id,
      'total_tax_account': taxAccount.id,
      'total_discount_account': discountAccount.id
    };
  }
}
