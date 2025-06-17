import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/adjustment_note_model.dart';
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
  final double? subTotal;
  final double? total;
  final String? description;
  final AdjustmentNoteAccountEntity? primaryAccount;
  final AdjustmentNoteAccountEntity? secondaryAccount;
  final AdjustmentNoteAccountEntity? taxAccount;
  final double? taxAmount;
  final int? chequeId;

  final List<AdjustmentNoteItemEntity>? adjustmentNoteItems;

  const AdjustmentNoteEntity(
      {this.id,
      this.adjustmentNoteNumber,
      this.documentNumber,
      this.adjustmentNoteType,
      this.date,
      this.dueDate,
      this.status,
      this.subTotal,
      this.total,
      this.description,
      this.primaryAccount,
      this.secondaryAccount,
      this.taxAccount,
      this.taxAmount,
      this.adjustmentNoteItems,
      this.chequeId});

  AdjustmentNoteModel toModel() {
    return AdjustmentNoteModel(
        id: id,
        adjustmentNoteNumber: adjustmentNoteNumber,
        documentNumber: documentNumber,
        adjustmentNoteType: adjustmentNoteType,
        date: date,
        dueDate: dueDate,
        status: status,
        subTotal: subTotal,
        total: total,
        description: description,
        primaryAccount: primaryAccount,
        secondaryAccount: secondaryAccount,
        taxAccount: taxAccount,
        taxAmount: taxAmount,
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
        subTotal,
        total,
        description,
        primaryAccount,
        secondaryAccount,
        taxAccount,
        taxAmount,
        adjustmentNoteItems,
        chequeId
      ];
}
