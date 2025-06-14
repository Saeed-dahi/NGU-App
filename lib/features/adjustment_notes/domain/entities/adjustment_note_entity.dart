import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/adjustemnt_note_model.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_account_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_item_entity.dart';

class AdjustmentNoteEntity extends Equatable {
  final int? id;
  final int? adjustmentNoteNumber;
  final String? documentNumber;
  final String? adjustmentNoteType;
  final String? date;
  final String? dueDate;
  final String? status;
  final String? adjustmentNoteNature;
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
  final List<AdjustmentNoteItemEntity>? adjustmentNoteItems;

  const AdjustmentNoteEntity(
      {this.id,
      this.adjustmentNoteNumber,
      this.documentNumber,
      this.adjustmentNoteType,
      this.date,
      this.dueDate,
      this.status,
      this.adjustmentNoteNature,
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
      this.adjustmentNoteItems});

  AdjustmentNoteModel toModel() {
    return AdjustmentNoteModel(
        id: id,
        adjustmentNoteNumber: adjustmentNoteNumber,
        documentNumber: documentNumber,
        adjustmentNoteType: adjustmentNoteType,
        date: date,
        dueDate: dueDate,
        status: status,
        adjustmentNoteNature: adjustmentNoteNature,
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
        adjustmentNoteItems: adjustmentNoteItems);
  }

  @override
  List<Object?> get props => [
        id,
        adjustmentNoteNumber,
        documentNumber,
        adjustmentNoteType,
        date,
        dueDate,
        status,
        adjustmentNoteNature,
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
        adjustmentNoteItems
      ];
}
