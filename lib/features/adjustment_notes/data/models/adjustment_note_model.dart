import 'package:ngu_app/features/adjustment_notes/data/models/adjustment_note_account_model.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/adjustment_note_item_model.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';

class AdjustmentNoteModel extends AdjustmentNoteEntity {
  const AdjustmentNoteModel(
      {super.id,
      super.adjustmentNoteNumber,
      super.documentNumber,
      super.adjustmentNoteType,
      super.date,
      super.dueDate,
      super.status,
      super.subTotal,
      super.total,
      super.description,
      super.primaryAccount,
      super.secondaryAccount,
      super.taxAccount,
      super.taxAmount,
      super.adjustmentNoteItems,
      super.chequeId});

  factory AdjustmentNoteModel.fromJson(Map<String, dynamic> json) {
    return AdjustmentNoteModel(
        id: json['id'],
        adjustmentNoteNumber: json['number'],
        documentNumber: json['document_number'] ?? '',
        adjustmentNoteType: json['type'] ?? '',
        date: json['date'] ?? '',
        dueDate: json['due_date'] ?? '',
        status: json['status'] ?? '',
        subTotal: double.tryParse(json['sub_total'].toString()) ?? 0,
        total: double.tryParse(json['total'].toString()) ?? 0.0,
        description: json['description'],
        primaryAccount:
            AdjustmentNoteAccountModel.fromJson(json['primary_account']),
        secondaryAccount:
            AdjustmentNoteAccountModel.fromJson(json['secondary_account']),
        taxAccount: AdjustmentNoteAccountModel.fromJson(json['tax_account']),
        taxAmount: double.tryParse(json['tax_amount'].toString()) ?? 0.0,
        adjustmentNoteItems: json['items']
            ?.map<AdjustmentNoteItemModel>((adjustmentNote) =>
                AdjustmentNoteItemModel.fromJson(adjustmentNote))
            .toList(),
        chequeId: json['cheque_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': adjustmentNoteNumber,
      'document_number': documentNumber,
      'type': adjustmentNoteType,
      'status': status,
      'date': date,
      'description': description,
      'primary_account_id': primaryAccount!.id,
      'secondary_account_id': secondaryAccount!.id,
      'tax_account_id': taxAccount!.id,
      'sub_total': subTotal,
      'total': total,
    };
  }
}
