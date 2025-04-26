import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/domain/use_cases/create_cheque_use_case.dart';
import 'package:ngu_app/features/cheques/domain/use_cases/get_all_cheques_use_case.dart';
import 'package:ngu_app/features/cheques/domain/use_cases/show_cheque_use_case.dart';
import 'package:ngu_app/features/cheques/domain/use_cases/update_cheque_use_case.dart';

part 'cheque_event.dart';
part 'cheque_state.dart';

class ChequeBloc extends Bloc<ChequeEvent, ChequeState> {
  final ShowChequeUseCase showChequeUseCase;
  final GetAllChequesUseCase getAllChequesUseCase;
  final CreateChequeUseCase createChequeUseCase;
  final UpdateChequeUseCase updateChequeUseCase;

  ChequeBloc(
      {required this.showChequeUseCase,
      required this.getAllChequesUseCase,
      required this.createChequeUseCase,
      required this.updateChequeUseCase})
      : super(ChequeInitial()) {
    on<ShowChequeEvent>(_onShowCheque);
    on<GetAllChequesEvent>(_onGetAllCheques);
    on<CreateChequeEvent>(_onCreateCheque);
    on<UpdateChequeEvent>(_onUpdateCheque);
  }

  FutureOr<void> _onShowCheque(
      ShowChequeEvent event, Emitter<ChequeState> emit) async {
    var result = await showChequeUseCase(event.id, event.direction);

    result.fold((failure) {
      emit(ErrorChequeState(message: failure.errors['error']));
    }, (data) {
      emit(LoadedChequeState(enableEditing: false, cheque: data));
    });
  }

  FutureOr<void> _onGetAllCheques(
      GetAllChequesEvent event, Emitter<ChequeState> emit) async {
    var result = await getAllChequesUseCase();

    result.fold((failure) {
      emit(ErrorChequeState(message: failure.errors['error']));
    }, (data) {
      emit(LoadedChequesState(cheques: data));
    });
  }

  FutureOr<void> _onCreateCheque(
      CreateChequeEvent event, Emitter<ChequeState> emit) async {
    emit(LoadingChequeState());
    var result = await createChequeUseCase(event.cheque);

    result.fold((failure) {
      emit(ErrorChequeState(message: failure.errors['error']));
    }, (data) {
      emit(LoadedChequeState(enableEditing: false, cheque: data));
    });
  }

  FutureOr<void> _onUpdateCheque(
      UpdateChequeEvent event, Emitter<ChequeState> emit) async {
    emit(LoadingChequeState());
    var result = await updateChequeUseCase(event.cheque);

    result.fold((failure) {
      emit(ErrorChequeState(message: failure.errors['error']));
    }, (data) {
      emit(LoadedChequeState(enableEditing: false, cheque: data));
    });
  }
}
