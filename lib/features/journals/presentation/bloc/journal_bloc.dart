import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/transactions/domain/entities/transaction_entity.dart';
import 'package:ngu_app/core/helper/formatter_class.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
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

  JournalEntity? _journalEntity;
  get getJournalEntity => _journalEntity;

  late PlutoGridStateManager _stateManager;
  PlutoGridStateManager get getStateManger => _stateManager;
  set setStateManager(PlutoGridStateManager sts) => _stateManager = sts;

  List<TransactionEntity> get transactions {
    double? amount;
    return _stateManager.rows.where((row) {
      // Check if essential cells are not empty
      final accountCode = row.cells['account_code']?.value;

      final debit = FormatterClass.doubleFormatter(row.cells['debit']?.value);
      final credit = FormatterClass.doubleFormatter(row.cells['credit']?.value);
      amount = debit ?? credit;

      return accountCode != null &&
          accountCode.toString().isNotEmpty &&
          amount != null &&
          amount.toString().isNotEmpty;
    }).map((row) {
      return TransactionEntity(
        accountCode: row.cells['account_code']!.value,
        accountName: row.cells['account_name']!.value,
        type: FormatterClass.doubleFormatter(row.cells['debit']?.value) != null
            ? AccountNature.debit.name
            : AccountNature.credit.name,
        amount: amount!,
        description: row.cells['description']?.value ?? '',
        documentNumber: row.cells['document_number']?.value ?? '',
      );
    }).toList();
  }

  // _getDoubleValue(var value) {
  //   return value.runtimeType == double ? value : double.tryParse(value);
  // }

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
      _journalEntity = data;
      emit(LoadedJournalState(journalEntity: data));
    });
  }

  FutureOr<void> _onCreateJournalEvent(
      CreateJournalEvent event, Emitter<JournalState> emit) async {
    final result = await createJournalUseCase(event.journalEntity);

    result.fold((failure) {
      if (failure is ValidationFailure) {
        _showValidationError(failure);
      } else {
        emit(ErrorJournalState(message: failure.errors['error']));
      }
    }, (data) {
      _journalEntity = data;
      emit(LoadedJournalState(journalEntity: event.journalEntity));
    });
  }

  FutureOr<void> _onUpdateJournalEvent(
      UpdateJournalEvent event, Emitter<JournalState> emit) async {
    emit(LoadingJournalState());
    final result = await updateJournalUseCase(event.journalEntity);

    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(LoadedJournalState(journalEntity: event.journalEntity));
        _showValidationError(failure);
      } else {
        emit(ErrorJournalState(message: failure.errors['error']));
      }
    }, (data) {
      _journalEntity = data;
      emit(LoadedJournalState(journalEntity: event.journalEntity));
    });
  }

  void _showValidationError(ValidationFailure failure) {
    List<String> errors = failure.errors.entries.map(
      (error) {
        return '${error.value.join('\n')}';
      },
    ).toList();
    ShowSnackBar.showValidationSnackbar(messages: errors);
  }
}
