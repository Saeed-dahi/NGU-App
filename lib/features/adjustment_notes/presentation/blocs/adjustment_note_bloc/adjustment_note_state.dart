part of 'adjustment_note_bloc.dart';

sealed class AdjustmentNoteState extends Equatable {
  const AdjustmentNoteState();

  @override
  List<Object> get props => [];
}

final class AdjustmentNoteInitial extends AdjustmentNoteState {}

class LoadedAllAdjustmentNotesState extends AdjustmentNoteState {
  final List<AdjustmentNoteEntity> adjustmentNotes;

  const LoadedAllAdjustmentNotesState({required this.adjustmentNotes});

  @override
  List<Object> get props => [adjustmentNotes];
}

class LoadedAdjustmentNoteState extends AdjustmentNoteState {
  final AdjustmentNoteEntity adjustmentNote;

  const LoadedAdjustmentNoteState({required this.adjustmentNote});
  @override
  List<Object> get props => [adjustmentNote];
}

class LoadingAdjustmentNoteState extends AdjustmentNoteState {}

class CreatedAdjustmentNoteState extends AdjustmentNoteState {}

class ErrorAdjustmentNoteState extends AdjustmentNoteState {
  final String error;

  const ErrorAdjustmentNoteState({required this.error});
  @override
  List<Object> get props => [error];
}
