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

class UpdateAccountInformationEvent extends AccountInformationEvent {
  final AccountInformationEntity accountInformationEntity;
  final List<File> files;
  final List<String> filesToDelete;

  const UpdateAccountInformationEvent(
      {required this.accountInformationEntity,
      required this.files,
      required this.filesToDelete});
}
