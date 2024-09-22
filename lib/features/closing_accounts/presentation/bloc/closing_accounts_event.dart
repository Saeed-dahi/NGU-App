part of 'closing_accounts_bloc.dart';

sealed class ClosingAccountsEvent extends Equatable {
  const ClosingAccountsEvent();

  @override
  List<Object> get props => [];
}

class GetAllClosingAccountsEvent extends ClosingAccountsEvent {}

class RefreshClosingsAccountsEvent extends ClosingAccountsEvent {}

class ShowClosingsAccountsEvent extends ClosingAccountsEvent {
  final int accountId;
  final String? direction;

  const ShowClosingsAccountsEvent({
    required this.accountId,
    this.direction,
  });
}

class AddNewClosingAccountEvent extends ClosingAccountsEvent {}

class UpdateClosingAccountEvent extends ClosingAccountsEvent {}
