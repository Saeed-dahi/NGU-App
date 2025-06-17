// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/accounts/domain/use_cases/get_accounts_name_use_case.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/adjustment_note_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/params/adjustment_note_items_entity_params.dart';
import 'package:ngu_app/features/adjustment_notes/domain/entities/preview_adjustment_note_item_entity.dart';
import 'package:ngu_app/features/adjustment_notes/domain/use_cases/create_adjustment_note_use_case.dart';
import 'package:ngu_app/features/adjustment_notes/domain/use_cases/get_all_adjustment_notes_use_case.dart';
import 'package:ngu_app/features/adjustment_notes/domain/use_cases/get_create_adjustment_note_form_data_use_case.dart';
import 'package:ngu_app/features/adjustment_notes/domain/use_cases/show_adjustment_note_use_case.dart';
import 'package:ngu_app/features/adjustment_notes/domain/use_cases/update_adjustment_note_use_case.dart';

part 'adjustment_note_event.dart';
part 'adjustment_note_state.dart';

class AdjustmentNoteBloc
    extends Bloc<AdjustmentNoteEvent, AdjustmentNoteState> {
  final GetAllAdjustmentNotesUseCase getAllAdjustmentNotesUseCase;
  final ShowAdjustmentNoteUseCase showAdjustmentNoteUseCase;
  final CreateAdjustmentNoteUseCase createAdjustmentNoteUseCase;
  final UpdateAdjustmentNoteUseCase updateAdjustmentNoteUseCase;
  final GetAccountsNameUseCase getAccountsNameUseCase;
  final GetCreateAdjustmentNoteFormDataUseCase
      getCreateAdjustmentNoteFormDataUseCase;

  AdjustmentNoteEntity _adjustmentNoteEntity = const AdjustmentNoteEntity();
  AdjustmentNoteEntity get getAdjustmentNoteEntity => _adjustmentNoteEntity;

  bool isSavedAdjustmentNote = false;

  Map<String, dynamic> _validationErrors = {};
  Map<String, dynamic> get getValidationErrors => _validationErrors;

  late PlutoGridController _plutoGridController;
  PlutoGridController get getPlutoGridController => _plutoGridController;
  set setPlutoGridController(PlutoGridController sts) =>
      _plutoGridController = sts;

  List<AdjustmentNoteItemsEntityParams> get adjustmentItems {
    return _plutoGridController.stateManager!.rows.where((row) {
      final data = row.data;
      return data != null;
    }).map((row) {
      PreviewAdjustmentNoteItemEntity previewAdjustmentNoteItemEntity =
          row.data;
      return AdjustmentNoteItemsEntityParams(
          productUnitId:
              previewAdjustmentNoteItemEntity.productUnit.id.toString(),
          quantity: double.parse(row.cells['quantity']!.value.toString()),
          price: double.parse(row.cells['price']!.value.toString()));
    }).toList();
  }

  AdjustmentNoteBloc({
    required this.getAllAdjustmentNotesUseCase,
    required this.showAdjustmentNoteUseCase,
    required this.createAdjustmentNoteUseCase,
    required this.updateAdjustmentNoteUseCase,
    required this.getAccountsNameUseCase,
    required this.getCreateAdjustmentNoteFormDataUseCase,
  }) : super(AdjustmentNoteInitial()) {
    on<GetAllAdjustmentNoteEvent>(_getAllAdjustmentNotes);
    on<ShowAdjustmentNoteEvent>(_showAdjustmentNote);
    on<CreateAdjustmentNoteEvent>(_createAdjustmentNote);
    on<UpdateAdjustmentNoteEvent>(_updateAdjustmentNote);
    on<GetCreateAdjustmentNoteFormData>(_createFormData);
  }

  FutureOr<void> _getAllAdjustmentNotes(GetAllAdjustmentNoteEvent event,
      Emitter<AdjustmentNoteState> emit) async {
    emit(LoadingAdjustmentNoteState());

    final result = await getAllAdjustmentNotesUseCase(event.type);
    result.fold((failure) {
      emit(ErrorAdjustmentNoteState(error: failure.errors['error']));
    }, (data) {
      emit(LoadedAllAdjustmentNotesState(adjustmentNotes: data));
    });
  }

  FutureOr<void> _showAdjustmentNote(
      ShowAdjustmentNoteEvent event, Emitter<AdjustmentNoteState> emit) async {
    _validationErrors = {};
    emit(LoadingAdjustmentNoteState());
    final result = await showAdjustmentNoteUseCase(
        event.adjustmentNoteQuery, event.direction, event.type, event.getBy);
    result.fold((failure) {
      emit(ErrorAdjustmentNoteState(error: failure.errors['error']));
    }, (data) {
      _adjustmentNoteEntity = data;
      emit(LoadedAdjustmentNoteState(adjustmentNote: _adjustmentNoteEntity));
    });
  }

  FutureOr<void> _createAdjustmentNote(CreateAdjustmentNoteEvent event,
      Emitter<AdjustmentNoteState> emit) async {
    emit(LoadingAdjustmentNoteState());

    final result = await createAdjustmentNoteUseCase(
        event.adjustmentNote, adjustmentItems);
    _createAndUpdateFoldResult(result, event, emit);
  }

  FutureOr<void> _updateAdjustmentNote(UpdateAdjustmentNoteEvent event,
      Emitter<AdjustmentNoteState> emit) async {
    emit(LoadingAdjustmentNoteState());

    final result = await updateAdjustmentNoteUseCase(
        event.adjustmentNote, adjustmentItems);

    _createAndUpdateFoldResult(result, event, emit);
  }

  void _createAndUpdateFoldResult(Either<Failure, AdjustmentNoteEntity> result,
      event, Emitter<AdjustmentNoteState> emit) {
    result.fold((failure) {
      if (failure is ValidationFailure) {
        _validationErrors = failure.errors;
        _adjustmentNoteEntity = event.adjustmentNote;

        ShowSnackBar.showValidationSnackbar(messages: ['error'.tr]);
        emit(LoadedAdjustmentNoteState(adjustmentNote: event.adjustmentNote));
      } else {
        emit(ErrorAdjustmentNoteState(error: failure.errors['error']));
      }
    }, (data) {
      _adjustmentNoteEntity = data;
      _validationErrors = {};
      emit(CreatedAdjustmentNoteState());
      emit(LoadedAdjustmentNoteState(adjustmentNote: data));
    });
  }

  FutureOr<void> _createFormData(GetCreateAdjustmentNoteFormData event,
      Emitter<AdjustmentNoteState> emit) async {
    final result = await getCreateAdjustmentNoteFormDataUseCase(event.type);

    result.fold((failure) {}, (data) {
      _adjustmentNoteEntity = data;

      emit(LoadedAdjustmentNoteState(adjustmentNote: data));
    });
  }
}
