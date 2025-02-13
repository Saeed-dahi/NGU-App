part of 'accounts_bloc.dart';

sealed class AccountsState extends Equatable {
  const AccountsState();

  @override
  List<Object> get props => [];
}

final class AccountsInitial extends AccountsState {}

class LoadingAccountsState extends AccountsState {}

class LoadedAccountsState extends AccountsState {
  final bool enableEditing;
  final AccountEntity accountEntity;

  const LoadedAccountsState(
      {required this.enableEditing, required this.accountEntity});
  @override
  List<Object> get props => [accountEntity, enableEditing];
}

class ErrorAccountsState extends AccountsState {
  final String message;

  const ErrorAccountsState({required this.message});

  @override
  List<Object> get props => [message];
}

class ValidationAccountState extends AccountsState {
  final Map<String, dynamic> errors;

  const ValidationAccountState({required this.errors});
}

class GetSuggestionCodeState extends AccountsState {
  final String code;

  const GetSuggestionCodeState({required this.code});
}

class GetAllAccountsState extends AccountsState {

}
