import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/features/transactions/domain/entities/transaction_entity.dart';
import 'package:ngu_app/features/journals/domain/entities/journal_entity.dart';
import 'package:ngu_app/features/journals/domain/use_cases/create_journal_use_case.dart';
import 'package:ngu_app/features/journals/domain/use_cases/get_all_journals_use_case.dart';
import 'package:ngu_app/features/journals/domain/use_cases/show_journal_use_case.dart';
import 'package:ngu_app/features/journals/domain/use_cases/update_journal_use_case.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

part 'journal_event.dart';
part 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  final GetAllJournalsUseCase getAllJournalsUseCase;
  final ShowJournalUseCase showJournalUseCase;
  final CreateJournalUseCase createJournalUseCase;
  final UpdateJournalUseCase updateJournalUseCase;

  late final JournalEntity _journalEntity;
  JournalEntity get getJournalEntity => _journalEntity;

  late PlutoGridStateManager _stateManager;
  PlutoGridStateManager get getStateManger => _stateManager;
  set setStateManager(PlutoGridStateManager sts) => _stateManager = sts;

  JournalBloc(
      {required this.getAllJournalsUseCase,
      required this.showJournalUseCase,
      required this.createJournalUseCase,
      required this.updateJournalUseCase})
      : super(JournalInitial()) {
    on<ShowJournalEvent>(_onShowJournalEvent);
    on<CreateJournalEvent>(_onCreateJournalEvent);
    on<UpdateJournalEvent>(_onUpdateJournalEvent);
  }

  FutureOr<void> _onShowJournalEvent(
      ShowJournalEvent event, Emitter<JournalState> emit) async {
    emit(LoadingJournalState());
    final result = await showJournalUseCase(event.journalId, event.direction);

    result.fold((failure) {
      emit(ErrorJournalState(message: failure.errors['error']));
    }, (data) {
      // _journalEntity = data;
      emit(LoadedJournalState(journalEntity: data));
    });
  }

  FutureOr<void> _onCreateJournalEvent(
      CreateJournalEvent event, Emitter<JournalState> emit) async {
    emit(LoadingJournalState());
    final result =
        await createJournalUseCase(event.journalEntity, event.transactions);

    result.fold((failure) {
      emit(ErrorJournalState(message: failure.errors['error']));
    }, (_) {});
  }

  FutureOr<void> _onUpdateJournalEvent(
      UpdateJournalEvent event, Emitter<JournalState> emit) async {
    emit(LoadingJournalState());

    final result =
        await createJournalUseCase(event.journalEntity, event.transactions);

    result.fold((failure) {
      emit(ErrorJournalState(message: failure.errors['error']));
    }, (_) {});
  }
}
