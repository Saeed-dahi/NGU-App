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
      required super.accountId,
      required super.goodsAccountId,
      required super.totalTaxAccount,
      required super.totalTax,
      required super.totalDiscountAccount,
      required super.totalDiscount,
      required super.invoiceItems});

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
        id: json['id'],
        invoiceNumber: json['invoice_number'],
        invoiceType: json['invoice_type'],
        date: json['date'],
        dueDate: json['due_date'],
        status: json['status'],
        invoiceNature: json['invoice_nature'],
        currency: json['currency'],
        subTotal: json['sub_total'],
        total: json['total'],
        notes: json['notes'] ?? '',
        accountId: json['account_id'],
        goodsAccountId: json['goods_account_id'],
        totalTaxAccount: json['total_tax_account'],
        totalTax: json['total_tax'],
        totalDiscountAccount: json['total_discount_account'],
        totalDiscount: json['total_discount'],
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
      'invoice_nature': invoiceNature,
      'currency': currency,
      'notes': notes,
      'account_id': accountId,
      'goods_account_id': 12,
      'total_tax_account': totalTaxAccount,
      'total_discount_account': totalDiscountAccount
    };
  }
}
