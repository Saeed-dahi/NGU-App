import 'package:ngu_app/features/closing_accounts/domain/entities/custom_account_entity.dart';

class CustomAccountModel extends CustomAccountEntity {
  const CustomAccountModel(
      {required super.id,
      required super.code,
      required super.arName,
      required super.enName,
      required super.balance});

  factory CustomAccountModel.fromJson(Map<String, dynamic> json) {
    return CustomAccountModel(
        id: json['id'],
        code: json['code'],
        arName: json['ar_name'],
        enName: json['en_name'],
        balance: double.parse(json['balance'].toString()));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'ar_name': arName,
      'en_name': enName,
      'balance': balance
    };
  }
}
