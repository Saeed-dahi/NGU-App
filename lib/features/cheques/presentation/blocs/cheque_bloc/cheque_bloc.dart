import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/upload/domain/entities/file_upload_entity.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:ngu_app/features/cheques/domain/use_cases/create_cheque_use_case.dart';
import 'package:ngu_app/features/cheques/domain/use_cases/deposit_cheque_use_case.dart';
import 'package:ngu_app/features/cheques/domain/use_cases/get_all_cheques_use_case.dart';
import 'package:ngu_app/features/cheques/domain/use_cases/get_cheques_per_account_use_case.dart';
import 'package:ngu_app/features/cheques/domain/use_cases/show_cheque_use_case.dart';
import 'package:ngu_app/features/cheques/domain/use_cases/update_cheque_use_case.dart';

part 'cheque_event.dart';
part 'cheque_state.dart';

class ChequeBloc extends Bloc<ChequeEvent, ChequeState> {
  late ChequeEntity _chequeEntity;
  ChequeEntity get chequeEntity => _chequeEntity;
  set chequeEntity(value) => _chequeEntity = value;

  final ShowChequeUseCase showChequeUseCase;
  final GetAllChequesUseCase getAllChequesUseCase;
  final CreateChequeUseCase createChequeUseCase;
  final UpdateChequeUseCase updateChequeUseCase;
  final DepositChequeUseCase depositChequeUseCase;
  final GetChequesPerAccountUseCase getChequesPerAccountUseCase;

  ChequeBloc({
    required this.showChequeUseCase,
    required this.getAllChequesUseCase,
    required this.createChequeUseCase,
    required this.updateChequeUseCase,
    required this.depositChequeUseCase,
    required this.getChequesPerAccountUseCase,
  }) : super(ChequeInitial()) {
    on<ShowChequeEvent>(_onShowCheque);
    on<GetAllChequesEvent>(_onGetAllCheques);
    on<CreateChequeEvent>(_onCreateCheque);
    on<UpdateChequeEvent>(_onUpdateCheque);
    on<ToggleEditingEvent>(_onToggleEditing);
    on<DepositChequeEvent>(_depositEvent);
    on<GetChequesPerAccountEvent>(_chequesPerAccount);
  }

  FutureOr<void> _onShowCheque(
      ShowChequeEvent event, Emitter<ChequeState> emit) async {
    emit(LoadingChequeState());
    var result = await showChequeUseCase(event.id, event.direction);

    result.fold((failure) {
      emit(ErrorChequeState(message: failure.errors['error']));
    }, (data) {
      _chequeEntity = data;
      emit(LoadedChequeState(enableEditing: false, cheque: data));
    });
  }

  FutureOr<void> _onGetAllCheques(
      GetAllChequesEvent event, Emitter<ChequeState> emit) async {
    emit(LoadingChequeState());

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
    var result =
        await createChequeUseCase(event.cheque, event.fileUploadEntity);

    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(ValidationChequeState(errors: failure.errors));
      } else {
        emit(ErrorChequeState(message: failure.errors['error']));
      }
    }, (data) {
      
      // print(data.id);
      // add(ShowChequeEvent(id: data.id!));
      emit(LoadedChequeState(enableEditing: false, cheque: data));
    });
  }

  FutureOr<void> _onUpdateCheque(
      UpdateChequeEvent event, Emitter<ChequeState> emit) async {
    emit(LoadingChequeState());
    var result =
        await updateChequeUseCase(event.cheque, event.fileUploadEntity);

    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(ValidationChequeState(errors: failure.errors));
      } else {
        emit(ErrorChequeState(message: failure.errors['error']));
      }
    }, (data) {
      // add(ShowChequeEvent(id: event.cheque.id!));
      emit(LoadedChequeState(enableEditing: false, cheque: data));
    });
  }

  FutureOr<void> _onToggleEditing(
      ToggleEditingEvent event, Emitter<ChequeState> emit) {
    final currentState = state as LoadedChequeState;

    emit(LoadedChequeState(
      cheque: currentState.cheque,
      enableEditing: event.enableEditing,
    ));
  }

  FutureOr<void> _depositEvent(
      DepositChequeEvent event, Emitter<ChequeState> emit) async {
    emit(LoadingChequeState());
    var result = await depositChequeUseCase(event.id);

    result.fold((failure) {
      emit(ErrorChequeState(message: failure.errors['errors']));
    }, (data) {
      add(ShowChequeEvent(id: event.id));
    });
  }

  FutureOr<void> _chequesPerAccount(
      GetChequesPerAccountEvent event, Emitter<ChequeState> emit) async {
    emit(LoadingChequeState());

    var result = await getChequesPerAccountUseCase(event.accountId);

    result.fold((failure) {
      emit(ErrorChequeState(message: failure.errors['error']));
    }, (data) {
      emit(LoadedChequesState(cheques: data));
    });
  }
}
