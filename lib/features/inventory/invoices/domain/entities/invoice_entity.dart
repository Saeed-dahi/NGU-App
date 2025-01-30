import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/invoice_model.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_item_entity.dart';

class InvoiceEntity extends Equatable {
  final int id;
  final int invoiceNumber;
  final String invoiceType;
  final String date;
  final String dueDate;
  final String status;
  final String invoiceNature;
  final String currency;
  final double subTotal;
  final double total;
  final String? notes;
  final InvoiceAccountEntity account;
  final InvoiceAccountEntity goodsAccount;
  final InvoiceAccountEntity taxAccount;
  final double totalTax;
  final InvoiceAccountEntity discountAccount;
  final double totalDiscount;
  final List<InvoiceItemEntity> invoiceItems;

  const InvoiceEntity(
      {required this.id,
      required this.invoiceNumber,
      required this.invoiceType,
      required this.date,
      required this.dueDate,
      required this.status,
      required this.invoiceNature,
      required this.currency,
      required this.subTotal,
      required this.total,
      required this.notes,
      required this.account,
      required this.goodsAccount,
      required this.taxAccount,
      required this.totalTax,
      required this.discountAccount,
      required this.totalDiscount,
      required this.invoiceItems});

  InvoiceModel toModel() {
    return InvoiceModel(
        id: id,
        invoiceNumber: invoiceNumber,
        invoiceType: invoiceType,
        date: date,
        dueDate: dueDate,
        status: status,
        invoiceNature: invoiceNature,
        currency: currency,
        subTotal: subTotal,
        total: total,
        notes: notes,
        account: account,
        goodsAccount: goodsAccount,
        taxAccount: taxAccount,
        totalTax: totalTax,
        discountAccount: discountAccount,
        totalDiscount: totalDiscount,
        invoiceItems: invoiceItems);
  }

  @override
  List<Object?> get props => [
        id,
        invoiceNumber,
        invoiceType,
        date,
        dueDate,
        status,
        invoiceNature,
        currency,
        subTotal,
        total,
        notes,
        account,
        goodsAccount,
        taxAccount,
        totalTax,
        discountAccount,
        totalDiscount,
        invoiceItems
      ];
}
