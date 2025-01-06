import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/inventory/stores/domain/entities/store_entity.dart';
import 'package:ngu_app/features/inventory/stores/domain/use_cases/create_store_use_case.dart';
import 'package:ngu_app/features/inventory/stores/domain/use_cases/get_stores_use_case.dart';
import 'package:ngu_app/features/inventory/stores/domain/use_cases/update_store_use_case.dart';
part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetStoresUseCase storesUseCase;
  final CreateStoreUseCase createStoreUseCase;
  final UpdateStoreUseCase updateStoreUseCase;

  late PlutoGridController plutoGridController;

  StoreBloc(
      {required this.storesUseCase,
      required this.createStoreUseCase,
      required this.updateStoreUseCase})
      : super(StoreInitial()) {
    on<GetStoresEvent>(_onGetStores);
    on<CreateStoreEvent>(_onCreateStore);
    on<UpdateStoreEvent>(_onUpdateStore);
  }

  FutureOr<void> _onGetStores(
      GetStoresEvent event, Emitter<StoreState> emit) async {
    emit(LoadingStoresState());

    var result = await storesUseCase();
    result.fold((failure) {
      emit(ErrorStoresState(message: failure.errors['error']));
    }, (data) {
      emit(LoadedStoresState(storeEntity: data));
    });
  }

  FutureOr<void> _onCreateStore(
    CreateStoreEvent event,
    Emitter<StoreState> emit,
  ) {
    _createOrUpdateStore(event, emit, createStoreUseCase);
  }

  FutureOr<void> _onUpdateStore(
      UpdateStoreEvent event, Emitter<StoreState> emit) async {
    _createOrUpdateStore(event, emit, updateStoreUseCase);
  }

  FutureOr<void> _createOrUpdateStore(
      dynamic event, Emitter<StoreState> emit, dynamic useCase) async {
    final result = await useCase(event.storeEntity);
    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(ValidationStoreState(errors: failure.errors));
      } else {
        emit(ErrorStoresState(message: failure.errors['error']));
      }
    }, (_) async {
      Get.back();
      add(GetStoresEvent());
    });
  }
}
