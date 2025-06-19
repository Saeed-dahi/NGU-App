part of 'adjustment_note_form_cubit.dart';

sealed class AdjustmentNoteFormState extends Equatable {
  const AdjustmentNoteFormState();

  @override
  List<Object> get props => [];
}

final class AdjustmentNoteFormInitial extends AdjustmentNoteFormState {}

class CheckedCreateChequeState extends AdjustmentNoteFormState {
  final bool createCheque;

  const CheckedCreateChequeState({required this.createCheque});

  @override
  List<Object> get props => [createCheque];
}
