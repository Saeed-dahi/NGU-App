import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';

class ClosingAccountModel extends ClosingAccountEntity {
  const ClosingAccountModel(
      {required super.id,
      required super.arName,
      required super.enName,
      required super.createdAt,
      required super.updatedAt});

  factory ClosingAccountModel.fromJson(Map<String, dynamic> json) {
    return ClosingAccountModel(
        id: json['id'],
        arName: json['ar_name'],
        enName: json['en_name'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ar_name': arName,
      'en_name': enName,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
