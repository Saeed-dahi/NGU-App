import 'package:ngu_app/features/cheques/domain/entities/cheque_account_entity.dart';

class ChequeAccountModel extends ChequeAccountEntity {
  ChequeAccountModel(
      {super.id, super.code, super.arName, super.enName, super.description});

  factory ChequeAccountModel.fromJson(Map<String, dynamic>? json) {
    return ChequeAccountModel(
        id: json?['id'],
        code: json?['code'],
        arName: json?['ar_name'],
        enName: json?['en_name'],
        description: json?['description']);
  }
}
