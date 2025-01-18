import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/closing_accounts/data/models/closing_account_model.dart';

class ClosingAccountEntity extends Equatable {
  final int? id;
  final String arName;
  final String enName;
  final String? createdAt;
  final String? updatedAt;

  const ClosingAccountEntity(
      {this.id,
      required this.arName,
      required this.enName,
      this.createdAt,
      this.updatedAt});

  ClosingAccountModel toModel() {
    return ClosingAccountModel(
        id: id,
        arName: arName,
        enName: enName,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }

  @override
  List<Object?> get props => [id, arName, enName, createdAt, updatedAt];
}
