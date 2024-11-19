import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<ChangeSideBarState> {
  HomeCubit() : super(const ChangeSideBarState(showSideBar: false));

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
}
