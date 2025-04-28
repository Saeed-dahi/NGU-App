part of 'cheque_bloc.dart';

sealed class ChequeEvent extends Equatable {
  const ChequeEvent();

  @override
  List<Object> get props => [];
}

class ShowChequeEvent extends ChequeEvent {
  final int id;
  final String? direction;

  const ShowChequeEvent({required this.id, this.direction});

  @override
  List<Object> get props => [id];
}

class GetAllChequesEvent extends ChequeEvent {}

class CreateChequeEvent extends ChequeEvent {
  final ChequeEntity cheque;

  const CreateChequeEvent({required this.cheque});

  @override
  List<Object> get props => [cheque];
}

class UpdateChequeEvent extends ChequeEvent {
  final ChequeEntity cheque;

  const UpdateChequeEvent({required this.cheque});

  @override
  List<Object> get props => [cheque];
}

class ToggleEditingEvent extends ChequeEvent {
  final bool enableEditing;

  const ToggleEditingEvent({required this.enableEditing});
}
