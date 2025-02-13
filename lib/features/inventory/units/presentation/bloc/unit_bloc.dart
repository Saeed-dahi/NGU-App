import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/inventory/units/domain/entities/unit_entity.dart';
import 'package:ngu_app/features/inventory/units/domain/use_cases/create_unit_use_case.dart';
import 'package:ngu_app/features/inventory/units/domain/use_cases/get_units_use_case.dart';
import 'package:ngu_app/features/inventory/units/domain/use_cases/update_unit_use_case.dart';

part 'unit_event.dart';
part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  final GetUnitsUseCase getUnitsUseCase;
  final CreateUnitUseCase createUnitUseCase;
  final UpdateUnitUseCase updateUnitUseCase;
  late PlutoGridController plutoGridController;

  UnitBloc(
      {required this.getUnitsUseCase,
      required this.createUnitUseCase,
      required this.updateUnitUseCase})
      : super(UnitInitial()) {
    on<GetUnitsEvent>(_onGetUnits);
    on<CreateUnitEvent>(_onCreateUnit);
    on<UpdateUnitEvent>(_onUpdateUnit);
  }

  FutureOr<void> _onGetUnits(
      GetUnitsEvent event, Emitter<UnitState> emit) async {
    emit(LoadingUnitsState());

    final result = await getUnitsUseCase(
        productId: event.productId, showProductUnits: event.showProductUnits);

    result.fold((failure) {
      emit(ErrorUnitsState(message: failure.errors['error']));
    }, (data) {
      emit(LoadedUnitsState(units: data));
    });
  }

  FutureOr<void> _onCreateUnit(
      CreateUnitEvent event, Emitter<UnitState> emit) async {
    await _createOrUpdateUnit(event, emit, createUnitUseCase);
  }

  FutureOr<void> _onUpdateUnit(
      UpdateUnitEvent event, Emitter<UnitState> emit) async {
    await _createOrUpdateUnit(event, emit, updateUnitUseCase);
  }

  FutureOr<void> _createOrUpdateUnit(
      dynamic event, Emitter<UnitState> emit, dynamic useCase) async {
    final result = await useCase(event.unit);

    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(ValidationUnitState(errors: failure.errors));
      } else {
        emit(ErrorUnitsState(message: failure.errors['error']));
      }
    }, (_) {
      Get.back();
      add(const GetUnitsEvent());
    });
  }
}
