import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/create_account_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/get_all_accounts_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/get_suggestion_code_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/search_in_accounts_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/show_account_use_case.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/update_account_use_case.dart';
part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  final CreateAccountUseCase createAccountUseCase;
  final GetAllAccountsUseCase getAllAccountsUseCase;
  final ShowAccountUseCase showAccountUseCase;
  final UpdateAccountUseCase updateAccountUseCase;
  final GetSuggestionCodeUseCase getSuggestionCodeUseCase;
  final SearchInAccountsUseCase searchInAccountsUseCase;

  AccountsBloc({
    required this.createAccountUseCase,
    required this.getAllAccountsUseCase,
    required this.showAccountUseCase,
    required this.updateAccountUseCase,
    required this.getSuggestionCodeUseCase,
    required this.searchInAccountsUseCase,
  }) : super(AccountsInitial()) {
    on<ShowAccountsEvent>(_onShowAccount);
    on<GetSuggestionCodeEvent>(_onGetSuggestionCode);
    on<CreateAccountEvent>(_onCreateAccount);
    on<GetAllAccountsEvent>(_onGetAllAccounts);
    on<UpdateAccountEvent>(_onUpdateAccount);
    on<ToggleEditingEvent>(_onToggleEditing);
    on<SearchInAccountsEvent>(_onSearchInAccounts);
  }

  _onShowAccount(ShowAccountsEvent event, Emitter<AccountsState> emit) async {
    emit(LoadingAccountsState());

    var result = await showAccountUseCase(event.accountId, event.direction);

    result.fold((failure) {
      emit(ErrorAccountsState(message: failure.errors['error']));
    }, (data) {
      emit(LoadedAccountsState(enableEditing: false, accountEntity: data));
    });
  }

  _onGetSuggestionCode(
      GetSuggestionCodeEvent event, Emitter<AccountsState> emit) async {
    emit(LoadingAccountsState());
    var result = await getSuggestionCodeUseCase(event.parentId);

    result.fold((failure) {
      Get.back();
      ShowSnackBar.showValidationSnackbar(messages: [failure.errors['error']]);
    }, (code) {
      emit(GetSuggestionCodeState(code: code));
    });
  }

  _onCreateAccount(
      CreateAccountEvent event, Emitter<AccountsState> emit) async {
    final result = await createAccountUseCase(event.accountEntity);
    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(ValidationAccountState(errors: failure.errors));
      } else {
        emit(ErrorAccountsState(message: failure.errors['error']));
      }
    }, (_) {
      Get.back();
      ShowSnackBar.showSuccessSnackbar(message: 'success'.tr);
    });
  }

  _onUpdateAccount(
      UpdateAccountEvent event, Emitter<AccountsState> emit) async {
    emit(LoadingAccountsState());
    final result = await updateAccountUseCase(event.accountEntity);
    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(ValidationAccountState(errors: failure.errors));
      } else {
        emit(ErrorAccountsState(message: failure.errors['error']));
      }
    }, (_) {
      emit(LoadedAccountsState(
          enableEditing: false, accountEntity: event.accountEntity));
      ShowSnackBar.showSuccessSnackbar(message: 'success'.tr);
    });
  }

  _onGetAllAccounts(
      GetAllAccountsEvent event, Emitter<AccountsState> emit) async {
    emit(LoadingAccountsState());
    final result = await getAllAccountsUseCase();
    result.fold((failure) {
      emit(ErrorAccountsState(message: failure.errors['error']));
    }, (data) {
      emit(GetAllAccountsState(accounts: data));
    });
  }

  _onSearchInAccounts(
      SearchInAccountsEvent event, Emitter<AccountsState> emit) async {
    emit(LoadingAccountsState());
    final result = await searchInAccountsUseCase(event.query);

    result.fold((failure) {}, (data) {
      emit(GetAllAccountsState(accounts: data));
    });
  }

  FutureOr<void> _onToggleEditing(
      ToggleEditingEvent event, Emitter<AccountsState> emit) {
    final currentState = state as LoadedAccountsState;

    emit(LoadedAccountsState(
      accountEntity: currentState.accountEntity,
      enableEditing: event.enableEditing,
    ));
  }
}
