import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/cheques/data/models/cheque_model.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_account_entity.dart';

class ChequeEntity extends Equatable {
  final int? id;
  final double? amount;
  final int? chequeNumber;

  final String? status;
  final String? date;
  final String? dueDate;
  final String? nature;
  final String? image;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;
  final ChequeAccountEntity? issuedFromAccount;
  final ChequeAccountEntity? issuedToAccount;
  final ChequeAccountEntity? targetBankAccount;

  const ChequeEntity(
      {this.id,
      required this.amount,
      required this.chequeNumber,
      this.status,
      required this.date,
      required this.dueDate,
      required this.nature,
      this.image,
      required this.notes,
      this.createdAt,
      this.updatedAt,
      required this.issuedFromAccount,
      required this.issuedToAccount,
      required this.targetBankAccount});

  ChequeModel toModel() {
    return ChequeModel(
        id: id,
        amount: amount,
        chequeNumber: chequeNumber,
        status: status,
        date: date,
        dueDate: dueDate,
        nature: nature,
        image: image,
        notes: notes,
        createdAt: createdAt,
        updatedAt: updatedAt,
        issuedFromAccount: issuedFromAccount,
        issuedToAccount: issuedToAccount,
        targetBankAccount: targetBankAccount);
  }

  @override
  List<Object?> get props => [
        id,
        amount,
        chequeNumber,
        status,
        date,
        dueDate,
        nature,
        image,
        notes,
        createdAt,
        updatedAt,
        issuedFromAccount,
        issuedToAccount,
        targetBankAccount
      ];
}
