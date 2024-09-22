part of 'closing_accounts_bloc.dart';

sealed class ClosingAccountsState extends Equatable {
  const ClosingAccountsState();

  @override
  List<Object> get props => [];
}

final class ClosingAccountsInitial extends ClosingAccountsState {}

class LoadingClosingAccountsState extends ClosingAccountsState {}

class LoadedClosingAccountsState extends ClosingAccountsState {
  final ClosingAccountEntity closingAccounts;

  const LoadedClosingAccountsState({required this.closingAccounts});

  @override
  List<Object> get props => [closingAccounts];
}

class ErrorClosingAccountsState extends ClosingAccountsState {
  final String message;

  const ErrorClosingAccountsState({required this.message});

  @override
  List<Object> get props => [message];
}
