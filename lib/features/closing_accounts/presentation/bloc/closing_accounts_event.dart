part of 'closing_accounts_bloc.dart';

sealed class ClosingAccountsEvent extends Equatable {
  const ClosingAccountsEvent();

  @override
  List<Object> get props => [];
}

class GetAllClosingAccountsEvent extends ClosingAccountsEvent {}

class ToggleEditingEvent extends ClosingAccountsEvent {
  final bool enableEditing;

  const ToggleEditingEvent({required this.enableEditing});
}

class ShowClosingsAccountsEvent extends ClosingAccountsEvent {
  final int accountId;
  final String? direction;

  const ShowClosingsAccountsEvent({
    required this.accountId,
    this.direction,
  });
}

class CreateClosingAccountEvent extends ClosingAccountsEvent {
  final ClosingAccountEntity closingAccountEntity;

  const CreateClosingAccountEvent({required this.closingAccountEntity});
}

class UpdateClosingAccountEvent extends ClosingAccountsEvent {
  final ClosingAccountEntity closingAccountEntity;

  const UpdateClosingAccountEvent({required this.closingAccountEntity});
}
