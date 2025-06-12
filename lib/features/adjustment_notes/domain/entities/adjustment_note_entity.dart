import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/adjustemnt_note_model.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_account_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_item_entity.dart';

class AdjustmentNoteEntity extends Equatable {
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
  final AdjustmentNoteAccountEntity? account;
  final AdjustmentNoteAccountEntity? goodsAccount;
  final AdjustmentNoteAccountEntity? taxAccount;
  final double? taxAmount;
  final AdjustmentNoteAccountEntity? discountAccount;
  final double? discountAmount;
  final String? discountType;
  final List<AdjustmentNoteItemEntity>? invoiceItems;

  const AdjustmentNoteEntity(
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
      this.taxAmount,
      this.discountAccount,
      this.discountAmount,
      this.discountType,
      this.invoiceItems});

  AdjustmentNoteModel toModel() {
    return AdjustmentNoteModel(
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
        taxAmount: taxAmount,
        discountAccount: discountAccount,
        discountAmount: discountAmount,
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
        taxAmount,
        discountAccount,
        discountAmount,
        discountType,
        invoiceItems
      ];
}
