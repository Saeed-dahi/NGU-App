part of 'adjustment_note_bloc.dart';

sealed class AdjustmentNoteEvent extends Equatable {
  const AdjustmentNoteEvent();

  @override
  List<Object> get props => [];
}

class GetAllAdjustmentNoteEvent extends AdjustmentNoteEvent {
  final String type;

  const GetAllAdjustmentNoteEvent({required this.type});
}

class ShowAdjustmentNoteEvent extends AdjustmentNoteEvent {
  final int adjustmentNoteQuery;
  final String? direction;
  final String type;
  final String? getBy;

  const ShowAdjustmentNoteEvent(
      {required this.adjustmentNoteQuery,
      this.direction,
      required this.type,
      this.getBy});
}

class CreateAdjustmentNoteEvent extends AdjustmentNoteEvent {
  final AdjustmentNoteEntity adjustmentNote;

  const CreateAdjustmentNoteEvent({required this.adjustmentNote});
}

class UpdateAdjustmentNoteEvent extends AdjustmentNoteEvent {
  final AdjustmentNoteEntity adjustmentNote;

  const UpdateAdjustmentNoteEvent({required this.adjustmentNote});
}

class GetCreateAdjustmentNoteFormData extends AdjustmentNoteEvent {
  final String type;

  const GetCreateAdjustmentNoteFormData({required this.type});
}
