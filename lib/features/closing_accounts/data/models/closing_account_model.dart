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
      if (id != null) 'id': id.toString(),
      'ar_name': arName,
      'en_name': enName,
      if (createdAt != null) 'created_at': createdAt,
      if (createdAt != null) 'updated_at': updatedAt,
    };
  }
}
