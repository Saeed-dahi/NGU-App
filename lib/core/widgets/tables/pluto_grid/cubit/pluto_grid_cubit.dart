import 'package:flutter_bloc/flutter_bloc.dart';

part 'pluto_grid_state.dart';

class PlutoGridCubit extends Cubit<OnChangeState> {
  PlutoGridCubit() : super(OnChangeState());

  void onChangeFunction() {
    emit(OnChangeState());
  }
}
