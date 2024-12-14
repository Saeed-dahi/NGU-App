import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/features/accounts/domain/use_cases/get_accounts_name_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<ChangeSideBarState> {
  GetAccountsNameUseCase getAccountsNameUseCase;
  late List<String> _accountsNameList;
  List<String> get accountsNameList => _accountsNameList;
  late Map<String, dynamic> _accountsNameMap = {};
  Map<String, dynamic> get accountsNameMap => _accountsNameMap;

  HomeCubit(this.getAccountsNameUseCase)
      : super(const ChangeSideBarState(showSideBar: false));

  showBigSideBar(String pressedButton) {
    if (state.showSideBar) {
      emit(const ChangeSideBarState(showSideBar: false));
    } else {
      emit(ChangeSideBarState(showSideBar: true, pressedButton: pressedButton));
    }
  }

  hideBigSideBar() {
    emit(const ChangeSideBarState(showSideBar: false));
  }

  getAccountsName() async {
    final result = await getAccountsNameUseCase();

    result.fold((failure) {}, (data) {
      _accountsNameList = data.entries
          .map(
            (e) => !e.key.startsWith('id')
                ? '${e.key} - ${e.value.toString()}'
                : '',
          )
          .toList();
      _accountsNameMap = data;
    });
  }


}
