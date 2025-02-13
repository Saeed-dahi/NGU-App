part of 'account_information_bloc.dart';

sealed class AccountInformationState extends Equatable {
  const AccountInformationState();

  @override
  List<Object> get props => [];
}

final class AccountInformationInitial extends AccountInformationState {}

class ErrorAccountInformationState extends AccountInformationState {
  final String message;

  const ErrorAccountInformationState({required this.message});
}

class LoadingAccountInformationState extends AccountInformationState {}

class LoadedAccountInformationState extends AccountInformationState {
  final AccountInformationEntity accountInformationEntity;

  const LoadedAccountInformationState({required this.accountInformationEntity});
}

class ValidationAccountInformationState extends AccountInformationState {
  final Map<String, dynamic> errors;

  const ValidationAccountInformationState({required this.errors});
}
