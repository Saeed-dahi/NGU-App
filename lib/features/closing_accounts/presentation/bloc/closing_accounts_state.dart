part of 'closing_accounts_bloc.dart';

sealed class ClosingAccountsState extends Equatable {
  const ClosingAccountsState();

  @override
  List<Object> get props => [];
}

final class ClosingAccountsInitial extends ClosingAccountsState {}

class LoadingClosingAccountsState extends ClosingAccountsState {}

class LoadedClosingAccountsState extends ClosingAccountsState {
  final bool enableEditing;
  final ClosingAccountEntity closingAccounts;

  const LoadedClosingAccountsState(
      {required this.enableEditing, required this.closingAccounts});

  @override
  List<Object> get props => [closingAccounts, enableEditing];
}

class ErrorClosingAccountsState extends ClosingAccountsState {
  final String message;

  const ErrorClosingAccountsState({required this.message});

  @override
  List<Object> get props => [message];
}

class ValidationClosingAccountState extends ClosingAccountsState {
  final Map<String, dynamic> errors;

  const ValidationClosingAccountState({required this.errors});
}
