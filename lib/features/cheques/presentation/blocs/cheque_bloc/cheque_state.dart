part of 'cheque_bloc.dart';

sealed class ChequeState extends Equatable {
  const ChequeState();

  @override
  List<Object> get props => [];
}

final class ChequeInitial extends ChequeState {}

class LoadingChequeState extends ChequeState {}

class LoadedChequesState extends ChequeState {
  final List<ChequeEntity> cheques;

  const LoadedChequesState({required this.cheques});

  @override
  List<Object> get props => [cheques];
}

class LoadedChequeState extends ChequeState {
  final bool enableEditing;
  final ChequeEntity cheque;

  const LoadedChequeState({required this.enableEditing, required this.cheque});

  @override
  List<Object> get props => [enableEditing, cheque];
}

class ErrorChequeState extends ChequeState {
  final String message;

  const ErrorChequeState({required this.message});

  @override
  List<Object> get props => [message];
}

class ValidationChequeState extends ChequeState {
  final Map<String, dynamic> errors;

  const ValidationChequeState({required this.errors});

  @override
  List<Object> get props => [errors];
}
