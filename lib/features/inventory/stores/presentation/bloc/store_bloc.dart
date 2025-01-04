import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ngu_app/features/inventory/stores/domain/entities/store_entity.dart';
import 'package:ngu_app/features/inventory/stores/domain/usecases/get_stores_use_case.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetStoresUseCase storesUseCase;

  StoreBloc({required this.storesUseCase}) : super(StoreInitial()) {
    on<GetStoresEvent>(_onGetStores);
  }

  FutureOr<void> _onGetStores(
      GetStoresEvent event, Emitter<StoreState> emit) async {
    emit(LoadingStoresState());

    var result = await storesUseCase();
    result.fold((failure) {
      emit(ErrorStoresState(message: failure.errors['error']));
    }, (data) {
      emit(LoadedStoresState(enableEditing: false, storeEntity: data));
    });
  }
}
