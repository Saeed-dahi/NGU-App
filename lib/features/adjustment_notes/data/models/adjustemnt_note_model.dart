import 'package:ngu_app/features/adjustment_notes/data/models/adjustemnt_note_account_model.dart';
import 'package:ngu_app/features/adjustment_notes/data/models/adjustemnt_note_item_model.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';

class AdjustmentNoteModel extends AdjustmentNoteEntity {
  const AdjustmentNoteModel(
      {super.id,
      super.invoiceNumber,
      super.documentNumber,
      super.invoiceType,
      super.date,
      super.dueDate,
      super.status,
      super.invoiceNature,
      super.address,
      super.currency,
      super.subTotal,
      super.total,
      super.notes,
      super.description,
      super.account,
      super.goodsAccount,
      super.taxAccount,
      super.taxAmount,
      super.discountAccount,
      super.discountAmount,
      super.discountType,
      super.invoiceItems});

  factory AdjustmentNoteModel.fromJson(Map<String, dynamic> json) {
    return AdjustmentNoteModel(
      id: json['id'],
      invoiceNumber: json['invoice_number'],
      documentNumber: json['document_number'] ?? '',
      invoiceType: json['type'] ?? '',
      date: json['date'] ?? '',
      dueDate: json['due_date'] ?? '',
      status: json['status'] ?? '',
      invoiceNature: json['invoice_nature'],
      address: json['address'] ?? '',
      currency: json['currency'] ?? '',
      subTotal: double.tryParse(json['sub_total'].toString()) ?? 0,
      total: double.tryParse(json['total'].toString()) ?? 0.0,
      notes: json['notes'] ?? '',
      description: json['description'],
      account: AdjustmentNoteAccountModel.fromJson(json['account']),
      goodsAccount: AdjustmentNoteAccountModel.fromJson(json['goods_account']),
      taxAccount: AdjustmentNoteAccountModel.fromJson(json['tax_account']),
      taxAmount: double.tryParse(json['tax_amount'].toString()) ?? 0.0,
      discountAccount:
          AdjustmentNoteAccountModel.fromJson(json['discount_account']),
      discountAmount:
          double.tryParse(json['discount_amount'].toString()) ?? 0.0,
      discountType: json['discount_type'] ?? '',
      invoiceItems: json['items']
          ?.map<AdjustmentNoteItemModel>(
              (invoice) => AdjustmentNoteItemModel.fromJson(invoice))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoice_number': invoiceNumber,
      'document_number': documentNumber,
      'type': invoiceType,
      'date': date,
      'due_date': dueDate,
      'status': status,
      'invoice_nature': invoiceNature,
      'address': address,
      'currency': 'AED',
      'notes': notes,
      'description': description,
      'account_id': account!.id,
      'goods_account_id': goodsAccount!.id,
      'tax_account_id': taxAccount!.id,
      'discount_account_id': discountAccount!.id,
      'discount_amount': discountAmount,
      'discount_type': discountType
    };
  }
}
