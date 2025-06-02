import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/invoice_model.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_account_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_item_entity.dart';

class InvoiceEntity extends Equatable {
  final int? id;
  final int? invoiceNumber;
  final String? documentNumber;
  final String? invoiceType;
  final String? date;
  final String? dueDate;
  final String? status;
  final String? invoiceNature;
  final String? address;
  final String? currency;
  final double? subTotal;
  final double? total;
  final String? notes;
  final String? description;
  final InvoiceAccountEntity? account;
  final InvoiceAccountEntity? goodsAccount;
  final InvoiceAccountEntity? taxAccount;
  final double? totalTax;
  final InvoiceAccountEntity? discountAccount;
  final double? totalDiscount;
  final String? discountType;
  final List<InvoiceItemEntity>? invoiceItems;

  const InvoiceEntity(
      {this.id,
      this.invoiceNumber,
      this.documentNumber,
      this.invoiceType,
      this.date,
      this.dueDate,
      this.status,
      this.invoiceNature,
      this.address,
      this.currency,
      this.subTotal,
      this.total,
      this.notes,
      this.description,
      this.account,
      this.goodsAccount,
      this.taxAccount,
      this.totalTax,
      this.discountAccount,
      this.totalDiscount,
      this.discountType,
      this.invoiceItems});

  InvoiceModel toModel() {
    return InvoiceModel(
        id: id,
        invoiceNumber: invoiceNumber,
        documentNumber: documentNumber,
        invoiceType: invoiceType,
        date: date,
        dueDate: dueDate,
        status: status,
        invoiceNature: invoiceNature,
        address: address,
        currency: currency,
        subTotal: subTotal,
        total: total,
        notes: notes,
        description: description,
        account: account,
        goodsAccount: goodsAccount,
        taxAccount: taxAccount,
        totalTax: totalTax,
        discountAccount: discountAccount,
        totalDiscount: totalDiscount,
        discountType: discountType,
        invoiceItems: invoiceItems);
  }

  @override
  List<Object?> get props => [
        id,
        invoiceNumber,
        documentNumber,
        invoiceType,
        date,
        dueDate,
        status,
        invoiceNature,
        address,
        currency,
        subTotal,
        total,
        notes,
        description,
        account,
        goodsAccount,
        taxAccount,
        totalTax,
        discountAccount,
        totalDiscount,
        discountType,
        invoiceItems
      ];
}
