import 'package:equatable/equatable.dart';

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
