part of 'account_information_bloc.dart';

sealed class AccountInformationEvent extends Equatable {
  const AccountInformationEvent();

  @override
  List<Object> get props => [];
}

class ShowAccountInformationEvent extends AccountInformationEvent {
  final int accountId;

  const ShowAccountInformationEvent({required this.accountId});
}

class UpdateAccountInformationEvent extends AccountInformationEvent {}
