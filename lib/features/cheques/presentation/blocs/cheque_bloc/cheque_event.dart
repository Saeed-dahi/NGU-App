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

class GetChequesPerAccountEvent extends ChequeEvent {
  final int accountId;

  const GetChequesPerAccountEvent({required this.accountId});
}

class CreateChequeEvent extends ChequeEvent {
  final ChequeEntity cheque;
  final FileUploadEntity fileUploadEntity;

  const CreateChequeEvent({
    required this.cheque,
    required this.fileUploadEntity,
  });

  @override
  List<Object> get props => [cheque];
}

class UpdateChequeEvent extends ChequeEvent {
  final ChequeEntity cheque;
  final FileUploadEntity fileUploadEntity;

  const UpdateChequeEvent(
      {required this.cheque, required this.fileUploadEntity});

  @override
  List<Object> get props => [cheque];
}

class DepositChequeEvent extends ChequeEvent {
  final int id;

  const DepositChequeEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class ToggleEditingEvent extends ChequeEvent {
  final bool enableEditing;

  const ToggleEditingEvent({required this.enableEditing});
}
