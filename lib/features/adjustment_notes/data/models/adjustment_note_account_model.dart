import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_account_entity.dart';

class AdjustmentNoteAccountModel extends AdjustmentNoteAccountEntity {
  AdjustmentNoteAccountModel(
      {super.id, super.code, super.arName, super.enName});

  factory AdjustmentNoteAccountModel.fromJson(Map<String, dynamic>? json) {
    return AdjustmentNoteAccountModel(
        id: json?['id'],
        code: json?['code'],
        arName: json?['ar_name'],
        enName: json?['en_name']);
  }
}
