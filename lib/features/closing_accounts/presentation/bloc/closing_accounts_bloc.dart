import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_entity.dart';

import 'package:ngu_app/features/closing_accounts/domain/use_cases/show_closing_account_use_case.dart';

part 'closing_accounts_event.dart';
part 'closing_accounts_state.dart';

class ClosingAccountsBloc
    extends Bloc<ClosingAccountsEvent, ClosingAccountsState> {
  final ShowClosingAccountUseCase showClosingAccountUseCase;

  ClosingAccountsBloc({required this.showClosingAccountUseCase})
      : super(ClosingAccountsInitial()) {
    on<ClosingAccountsEvent>((event, emit) async {
      if (event is ShowClosingsAccountsEvent) {
        emit(LoadingClosingAccountsState());
        final result =
            await showClosingAccountUseCase(event.accountId, event.direction);

        result.fold((failure) {
          emit(ErrorClosingAccountsState(message: failure.message[0]));
        }, (data) {
          emit(LoadedClosingAccountsState(closingAccounts: data));
        });
      }
    });
  }
}
