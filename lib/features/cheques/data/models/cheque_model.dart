import 'package:ngu_app/features/cheques/data/models/cheque_account_model.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';

class ChequeModel extends ChequeEntity {
  const ChequeModel(
      {super.id,
      super.amount,
      super.chequeNumber,
      super.status,
      super.date,
      super.dueDate,
      super.nature,
      super.images,
      super.notes,
      super.createdAt,
      super.updatedAt,
      super.issuedFromAccount,
      super.issuedToAccount,
      super.targetBankAccount});

  factory ChequeModel.fromJson(Map<String, dynamic> json) {
    return ChequeModel(
      id: json['id'],
      amount: double.tryParse(json['amount'].toString()),
      chequeNumber: int.tryParse(json['cheque_number'].toString()),
      status: json['status'],
      date: json['date'] ?? '',
      dueDate: json['due_date'] ?? '',
      nature: json['nature'] ?? '',
      images: json['image'] != null ? List<String>.from(json['image']) : null,
      notes: json['notes'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      issuedFromAccount:
          ChequeAccountModel.fromJson(json['issued_from_account']),
      issuedToAccount: ChequeAccountModel.fromJson(json['issued_to_account']),
      targetBankAccount:
          ChequeAccountModel.fromJson(json['target_bank_account']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (chequeNumber != null) 'cheque_number': chequeNumber,
      if (status != null) 'status': status,
      if (date != null) 'date': date,
      if (dueDate != null) 'due_date': dueDate,
      if (nature != null) 'nature': nature,
      if (images != null) 'image': images,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (issuedFromAccount != null)
        'issued_from_account_id': issuedFromAccount!.id,
      if (issuedToAccount != null) 'issued_to_account_id': issuedToAccount!.id,
      if (targetBankAccount != null)
        'target_bank_account_id': targetBankAccount!.id,
    };
  }
}
