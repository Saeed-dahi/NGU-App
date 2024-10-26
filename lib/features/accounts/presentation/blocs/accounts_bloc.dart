import 'dart:async';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_entity.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_statement_entity.dart';
import 'package:ngu_app/features/accounts/domain/use_cases/account_statement_use_case.dart';
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
  final AccountStatementUseCase accountStatementUseCase;

  final List<AccountEntity> _accounts = List.empty(growable: true);
  TreeNode _tree = TreeNode();
  final List<AccountEntity> _accountsTable = List.empty(growable: true);


  List<AccountEntity> get accounts => _accounts;
  TreeNode get tree => _tree;
  List<AccountEntity> get accountTable => _accountsTable;


  AccountsBloc(
      {required this.createAccountUseCase,
      required this.getAllAccountsUseCase,
      required this.showAccountUseCase,
      required this.updateAccountUseCase,
      required this.getSuggestionCodeUseCase,
      required this.searchInAccountsUseCase,
      required this.accountStatementUseCase})
      : super(AccountsInitial()) {
    on<ShowAccountsEvent>(_onShowAccount);
    on<GetSuggestionCodeEvent>(_onGetSuggestionCode);
    on<CreateAccountEvent>(_onCreateAccount);
    on<GetAllAccountsEvent>(_onGetAllAccounts);
    on<UpdateAccountEvent>(_onUpdateAccount);
    on<ToggleEditingEvent>(_onToggleEditing);
    on<SearchInAccountsEvent>(_onSearchInAccounts);
    on<AccountStatementEvent>(_onAccountStatement);
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
    tree.clear();
    accounts.clear();
    _accountsTable.clear();
    emit(LoadingAccountsState());
    final result = await getAllAccountsUseCase();

    result.fold((failure) {
      emit(ErrorAccountsState(message: failure.errors['error']));
    }, (data) {
      if (data.isEmpty) {
        emit(ErrorAccountsState(message: AppStrings.notFound.tr));
      } else {
        _accounts.addAll(data);
        _tree = _buildAccountsTree();
        _accountsTable.addAll(flattenAccounts(data));
        emit(GetAllAccountsState());
      }
    });
  }

  _onSearchInAccounts(
      SearchInAccountsEvent event, Emitter<AccountsState> emit) async {
    emit(LoadingAccountsState());
    final result = await searchInAccountsUseCase(event.query);

    result.fold((failure) {}, (data) {
      accountTable.clear();
      accountTable.addAll(data);
      emit(GetAllAccountsState());
    });
  }

  _onAccountStatement(
      AccountStatementEvent event, Emitter<AccountsState> emit) async {
    emit(LoadingAccountsState());

    final result = await accountStatementUseCase(event.accountId);

    result.fold((failure) {
      emit(ErrorAccountsState(message: failure.errors['error']));
    }, (data) {
      emit(AccountStatementState(statement: data));
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

  // Helper Functions
  List<AccountEntity> flattenAccounts(List<AccountEntity> accounts) {
    List<AccountEntity> allAccounts = [];
    for (var account in accounts) {
      allAccounts.add(account); // Add the main account
      if (account.subAccounts.isNotEmpty) {
        allAccounts.addAll(flattenAccounts(
            account.subAccounts)); // Recursively add sub-accounts
      }
    }
    return allAccounts;
  }

  // Tree Page
  TreeNode _buildAccountsTree() {
    var root = TreeNode(key: 'accounts_tree'.tr);

    root.addAll(_buildAccountNodes(_accounts));

    return root;
  }

  List<TreeNode> _buildAccountNodes(List<AccountEntity> accounts) {
    List<TreeNode> nodes = [];

    for (var account in accounts) {
      var node = TreeNode(key: account.arName, data: account);

      if (account.subAccounts.isNotEmpty) {
        node.addAll(_buildAccountNodes(account.subAccounts));
      }
      nodes.add(node);
    }
    return nodes;
  }
}
