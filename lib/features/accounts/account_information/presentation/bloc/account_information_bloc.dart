import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/accounts/account_information/domain/entities/account_information_entity.dart';
import 'package:ngu_app/features/accounts/account_information/domain/use_cases/show_account_information_use_case.dart';
import 'package:ngu_app/features/accounts/account_information/domain/use_cases/update_account_information_use_case.dart';

part 'account_information_event.dart';
part 'account_information_state.dart';

class AccountInformationBloc
    extends Bloc<AccountInformationEvent, AccountInformationState> {
  final ShowAccountInformationUseCase showAccountInformationUseCase;
  final UpdateAccountInformationUseCase updateAccountInformationUseCase;

  late AccountInformationEntity _accountInformationEntity;

  AccountInformationEntity get accountInformationEntity =>
      _accountInformationEntity;

  AccountInformationBloc(
      {required this.showAccountInformationUseCase,
      required this.updateAccountInformationUseCase})
      : super(AccountInformationInitial()) {
    on<ShowAccountInformationEvent>(_showAccountInformation);
    on<UpdateAccountInformationEvent>(_updateAccountInformation);
  }

  _showAccountInformation(ShowAccountInformationEvent event,
      Emitter<AccountInformationState> emit) async {
    emit(LoadingAccountInformationState());
    final result = await showAccountInformationUseCase(event.accountId);

    result.fold((failure) {
      emit(ErrorAccountInformationState(message: failure.errors['error']));
    }, (date) {
      _accountInformationEntity = date;
      emit(LoadedAccountInformationState(accountInformationEntity: date));
    });
  }

  _updateAccountInformation(UpdateAccountInformationEvent event,
      Emitter<AccountInformationState> emit) async {
    emit(LoadingAccountInformationState());
    final result = await updateAccountInformationUseCase(
        event.accountInformationEntity, event.files, event.filesToDelete);

    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(ValidationAccountInformationState(errors: failure.errors));
      } else {
        emit(ErrorAccountInformationState(message: failure.errors['error']));
      }
    }, (date) {
      emit(LoadedAccountInformationState(
          accountInformationEntity: event.accountInformationEntity));
    });
  }
}
