import 'package:equatable/equatable.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/invoice_model.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_item_entity.dart';

class InvoiceEntity extends Equatable {
  final int id;
  final int invoiceNumber;
  final InvoiceType invoiceType;
  final String date;
  final String dueDate;
  final Status status;
  final AccountNature invoiceNature;
  final String currency;
  final double subTotal;
  final double total;
  final String? notes;
  final int accountId;
  final int goodsAccountId;
  final int totalTaxAccount;
  final double totalTax;
  final int totalDiscountAccount;
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
      required this.accountId,
      required this.goodsAccountId,
      required this.totalTaxAccount,
      required this.totalTax,
      required this.totalDiscountAccount,
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
        accountId: accountId,
        goodsAccountId: goodsAccountId,
        totalTaxAccount: totalTaxAccount,
        totalTax: totalTax,
        totalDiscountAccount: totalDiscountAccount,
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
        accountId,
        goodsAccountId,
        totalTaxAccount,
        totalTax,
        totalDiscountAccount,
        totalDiscount,
        invoiceItems
      ];
}
