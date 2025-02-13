part of 'accounts_bloc.dart';

sealed class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object> get props => [];
}

class GetAllAccountsEvent extends AccountsEvent {}

class SearchInAccountsEvent extends AccountsEvent {
  final String query;

  const SearchInAccountsEvent({
    required this.query,
  });
}

class ShowAccountsEvent extends AccountsEvent {
  final int accountId;
  final String? direction;

  const ShowAccountsEvent({
    required this.accountId,
    this.direction,
  });
}

class CreateAccountEvent extends AccountsEvent {
  final AccountEntity accountEntity;

  const CreateAccountEvent({required this.accountEntity});
}

class UpdateAccountEvent extends AccountsEvent {
  final AccountEntity accountEntity;

  const UpdateAccountEvent({required this.accountEntity});
}

class ToggleEditingEvent extends AccountsEvent {
  final bool enableEditing;

  const ToggleEditingEvent({required this.enableEditing});
}

class GetSuggestionCodeEvent extends AccountsEvent {
  final int parentId;

  const GetSuggestionCodeEvent({required this.parentId});
}
