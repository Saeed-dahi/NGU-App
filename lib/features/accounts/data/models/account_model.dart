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
      required super.subAccounts,
      required super.createdAt,
      required super.updatedAt,
      required super.closingAccountId});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
        id: json['id'],
        code: json['code'],
        arName: json['ar_name'],
        enName: json['en_name'],
        accountType: json['account_type'],
        accountNature: json['account_nature'],
        accountCategory: json['account_category'],
        balance: double.tryParse(json['balance']?.toString() ?? '0.0'),
        closingAccountId: json['closing_account_id'],
        parentId: json['parent_id'],
        subAccounts: json['sub_accounts']
            ?.map<AccountModel>((e) => AccountModel.fromJson(e))
            .toList(),
        createdAt: json['created_at']?.toString(),
        updatedAt: json['updated_at']?.toString());
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id.toString(),
      'code': code,
      'ar_name': arName,
      'en_name': enName,
      'account_type': accountType,
      if (accountNature != null) 'account_nature': accountNature,
      if (accountCategory != null) 'account_category': accountCategory,
      if (closingAccountId != null)
        'closing_account_id': closingAccountId.toString(),
      if (parentId != null) 'parent_id': parentId.toString(),
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    };
  }
}
