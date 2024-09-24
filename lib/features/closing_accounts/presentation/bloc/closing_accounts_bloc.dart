import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/add_new_closing_account_use_case.dart';

import 'package:ngu_app/features/closing_accounts/domain/use_cases/show_closing_account_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/update_closing_account_use_case.dart';

part 'closing_accounts_event.dart';
part 'closing_accounts_state.dart';

class ClosingAccountsBloc
    extends Bloc<ClosingAccountsEvent, ClosingAccountsState> {
  final ShowClosingAccountUseCase showClosingAccountUseCase;
  final CreateClosingAccountUseCase createClosingAccountUseCase;
  final UpdateClosingAccountUseCase updateClosingAccountUseCase;

  ClosingAccountsBloc(
      {required this.showClosingAccountUseCase,
      required this.createClosingAccountUseCase,
      required this.updateClosingAccountUseCase})
      : super(ClosingAccountsInitial()) {
    on<ShowClosingsAccountsEvent>(_onShowClosingsAccounts);
    on<CreateClosingAccountEvent>(_onCreateClosingAccount);
    on<UpdateClosingAccountEvent>(_onUpdateClosingAccount);
  }

  Future<void> _onShowClosingsAccounts(ShowClosingsAccountsEvent event,
      Emitter<ClosingAccountsState> emit) async {
    emit(LoadingClosingAccountsState());

    final result =
        await showClosingAccountUseCase(event.accountId, event.direction);

    result.fold(
      (failure) {
        emit(ErrorClosingAccountsState(message: failure.errors['error']));
      },
      (data) {
        emit(LoadedClosingAccountsState(closingAccounts: data));
      },
    );
  }

  Future<void> _onCreateClosingAccount(CreateClosingAccountEvent event,
      Emitter<ClosingAccountsState> emit) async {
    await _handleCreateOrUpdateEventResult(
        emit, event, createClosingAccountUseCase);
  }

  Future<void> _onUpdateClosingAccount(UpdateClosingAccountEvent event,
      Emitter<ClosingAccountsState> emit) async {
    await _handleCreateOrUpdateEventResult(
        emit, event, updateClosingAccountUseCase);
  }

  Future<void> _handleCreateOrUpdateEventResult(
      Emitter<ClosingAccountsState> emit, event, function) async {
    emit(
      LoadingClosingAccountsState(),
    );
    final result = await function(event.closingAccountEntity);

    result.fold(
      (failure) {
        if (failure is ValidationFailure) {
          emit(ValidationClosingAccountState(errors: failure.errors));
        } else {
          emit(ErrorClosingAccountsState(message: failure.errors['error']));
        }
      },
      (_) {
        Get.back();
        ShowSnackBar.showSuccessSnackbar(message: 'success'.tr);
      },
    );
  }
}
