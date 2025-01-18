import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/accounts/data/models/account_model.dart';

class AccountEntity extends Equatable {
  final int? id;
  final String code;
  final String arName;
  final String enName;
  final String? accountType;
  final String? accountNature;
  final String? accountCategory;
  final double? balance;
  final int? closingAccountId;
  final int? parentId;
  final List<AccountEntity> subAccounts;
  final String? createdAt;
  final String? updatedAt;

  const AccountEntity(
      {this.id,
      required this.code,
      required this.arName,
      required this.enName,
      required this.accountType,
      this.accountNature,
      this.accountCategory,
      this.balance,
      this.closingAccountId,
      this.parentId,
      required this.subAccounts,
      this.createdAt,
      this.updatedAt});

  AccountModel toModel() {
    return AccountModel(
        id: id,
        code: code,
        arName: arName,
        enName: enName,
        accountType: accountType,
        accountNature: accountNature,
        accountCategory: accountCategory,
        balance: balance,
        parentId: parentId,
        subAccounts: subAccounts,
        createdAt: createdAt,
        updatedAt: updatedAt,
        closingAccountId: closingAccountId);
  }

  @override
  List<Object?> get props => [
        id,
        code,
        arName,
        enName,
        accountType,
        accountNature,
        accountCategory,
        balance,
        closingAccountId,
        parentId,
        subAccounts,
        createdAt,
        updatedAt
      ];
}
