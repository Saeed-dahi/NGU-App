import 'package:ngu_app/features/cheques/data/models/cheque_account_model.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';

class ChequeModel extends ChequeEntity {
  const ChequeModel(
      {required super.id,
      required super.amount,
      required super.chequeNumber,
      required super.status,
      required super.date,
      required super.dueDate,
      required super.nature,
      required super.image,
      required super.notes,
      required super.createdAt,
      required super.updatedAt,
      required super.issuedFromAccount,
      required super.issuedToAccount,
      required super.targetBankAccount});

  factory ChequeModel.fromJson(Map<String, dynamic> json) {
    return ChequeModel(
        id: json['id'],
        amount: double.tryParse(json['amount'].toString()),
        chequeNumber: json['cheque_number'],
        status: json['status'],
        date: json['date'] ?? '',
        dueDate: json['due_date'] ?? '',
        nature: json['nature'] ?? '',
        image: json['image'] ?? '',
        notes: json['notes'] ?? '',
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        issuedFromAccount:
            ChequeAccountModel.fromJson(json['issued_from_account']),
        issuedToAccount: ChequeAccountModel.fromJson(json['issued_to_account']),
        targetBankAccount:
            ChequeAccountModel.fromJson(json['target_bank_account']));
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
      if (image != null) 'image': image,
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
