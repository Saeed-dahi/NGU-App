import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  const AccountModel(
      {required super.id,
      required super.code,
      required super.arName,
      required super.enName,
      required super.accountType,
      required super.accountNature,
      required super.accountCategory,
      required super.balance,
      required super.parentId,
      required super.createdAt,
      required super.updatedAt});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
        id: json['id']?.toString(),
        code: json['code'],
        arName: json['ar_name'],
        enName: json['en_name'],
        accountType: json['account_type'],
        accountNature: json['account_nature'],
        accountCategory: json['account_category'],
        balance: double.tryParse(json['balance']?.toString() ?? '0.0'),
        parentId: json['parent_id']?.toString(),
        createdAt: json['created_at']?.toString(),
        updatedAt: json['updated_at']?.toString());
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'code': code,
      'ar_name': arName,
      'en_name': enName,
      'account_type': accountType,
      if (accountNature != null) 'account_nature': accountNature,
      if (accountCategory != null) 'account_category': accountCategory,
      if (balance != null) 'balance': balance,
      if (parentId != null) 'parent_id': parentId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    };
  }
}
