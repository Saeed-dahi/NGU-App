import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final String? id;
  final String code;
  final String arName;
  final String enName;
  final String? accountType;
  final String? accountNature;
  final String? accountCategory;
  final double? balance;
  final String? parentId;
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
      this.parentId,
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
        parentId,
        createdAt,
        updatedAt
      ];
}
