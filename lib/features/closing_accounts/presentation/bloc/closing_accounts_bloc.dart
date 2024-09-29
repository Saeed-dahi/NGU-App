import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';

import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/add_new_closing_account_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/get_all_closing_accounts_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/show_closing_account_use_case.dart';
import 'package:ngu_app/features/closing_accounts/domain/use_cases/update_closing_account_use_case.dart';
part 'closing_accounts_event.dart';
part 'closing_accounts_state.dart';

class ClosingAccountsBloc
    extends Bloc<ClosingAccountsEvent, ClosingAccountsState> {
  final ShowClosingAccountUseCase showClosingAccountUseCase;
  final CreateClosingAccountUseCase createClosingAccountUseCase;
  final UpdateClosingAccountUseCase updateClosingAccountUseCase;
  final GetAllClosingAccountsUseCase getAllClosingAccountsUseCase;

  ClosingAccountsBloc(
      {required this.showClosingAccountUseCase,
      required this.createClosingAccountUseCase,
      required this.updateClosingAccountUseCase,
      required this.getAllClosingAccountsUseCase})
      : super(ClosingAccountsInitial()) {
    on<ShowClosingsAccountsEvent>(_onShowClosingAccount);
    on<CreateClosingAccountEvent>(_onCreateClosingAccount);
    on<UpdateClosingAccountEvent>(_onUpdateClosingAccount);
    on<GetAllClosingAccountsEvent>(_onGetAllClosingAccount);
    on<ToggleEditingEvent>(_onToggleEditing);
  }

  Future<void> _onShowClosingAccount(ShowClosingsAccountsEvent event,
      Emitter<ClosingAccountsState> emit) async {
    emit(LoadingClosingAccountsState());

    final result =
        await showClosingAccountUseCase(event.accountId, event.direction);

    result.fold(
      (failure) {
        emit(ErrorClosingAccountsState(message: failure.errors['error']));
      },
      (data) {
        emit(LoadedClosingAccountsState(
            closingAccount: data, enableEditing: false));
      },
    );
  }

  Future<void> _onCreateClosingAccount(CreateClosingAccountEvent event,
      Emitter<ClosingAccountsState> emit) async {
    emit(
      LoadingClosingAccountsState(),
    );
    final result =
        await createClosingAccountUseCase(event.closingAccountEntity);

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

  Future<void> _onUpdateClosingAccount(UpdateClosingAccountEvent event,
      Emitter<ClosingAccountsState> emit) async {
    emit(
      LoadingClosingAccountsState(),
    );
    final result =
        await updateClosingAccountUseCase(event.closingAccountEntity);

    result.fold(
      (failure) {
        if (failure is ValidationFailure) {
          emit(ValidationClosingAccountState(errors: failure.errors));
        } else {
          emit(ErrorClosingAccountsState(message: failure.errors['error']));
        }
      },
      (_) {
        emit(LoadedClosingAccountsState(
            enableEditing: false, closingAccount: event.closingAccountEntity));
        ShowSnackBar.showSuccessSnackbar(message: 'success'.tr);
      },
    );
  }

  Future<void> _onGetAllClosingAccount(GetAllClosingAccountsEvent event,
      Emitter<ClosingAccountsState> emit) async {
    emit(LoadingClosingAccountsState());

    final result = await getAllClosingAccountsUseCase();

    result.fold(
      (failure) {
        emit(ErrorClosingAccountsState(message: failure.errors['error']));
      },
      (data) {
      

        emit(
          LoadedAllClosingAccountsState(closingAccounts: data),
        );
      },
    );
  }

  FutureOr<void> _onToggleEditing(
      ToggleEditingEvent event, Emitter<ClosingAccountsState> emit) {
    final currentState = state as LoadedClosingAccountsState;

    emit(LoadedClosingAccountsState(
      closingAccount: currentState.closingAccount,
      enableEditing: event.enableEditing,
    ));
  }
}
