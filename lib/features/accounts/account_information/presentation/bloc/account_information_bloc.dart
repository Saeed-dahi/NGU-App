import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/features/accounts/account_information/domain/entities/account_information_entity.dart';
import 'package:ngu_app/features/accounts/account_information/domain/use_cases/show_account_information_use_case.dart';
import 'package:ngu_app/features/accounts/account_information/domain/use_cases/update_account_information_use_case.dart';
part 'account_information_event.dart';
part 'account_information_state.dart';

class AccountInformationBloc
    extends Bloc<AccountInformationEvent, AccountInformationState> {
  final ShowAccountInformationUseCase showAccountInformationUseCase;
  final UpdateAccountInformationUseCase updateAccountInformationUseCase;
  AccountInformationBloc(
      {required this.showAccountInformationUseCase,
      required this.updateAccountInformationUseCase})
      : super(AccountInformationInitial()) {
    on<ShowAccountInformationEvent>(_showAccountInformation);
  }

  _showAccountInformation(ShowAccountInformationEvent event,
      Emitter<AccountInformationState> emit) async {
    emit(LoadingAccountInformationState());
    final result = await showAccountInformationUseCase(event.accountId);

    result.fold((failure) {
      emit(ErrorAccountInformationState(message: failure.errors['error']));
    }, (date) {
      emit(LoadedAccountInformationState(accountInformationEntity: date));
    });
  }
}
