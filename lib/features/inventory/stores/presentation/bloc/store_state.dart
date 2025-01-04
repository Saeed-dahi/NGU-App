part of 'store_bloc.dart';

sealed class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

final class StoreInitial extends StoreState {}

class LoadedStoresState extends StoreState {
  final bool enableEditing;
  final List<StoreEntity> storeEntity;

  const LoadedStoresState(
      {required this.enableEditing, required this.storeEntity});
  @override
  List<Object> get props => [storeEntity, enableEditing];
}

class ErrorStoresState extends StoreState {
  final String message;

  const ErrorStoresState({required this.message});

  @override
  List<Object> get props => [message];
}

class ValidationStoreState extends StoreState {
  final Map<String, dynamic> errors;

  const ValidationStoreState({required this.errors});
}

class LoadingStoresState extends StoreState {}

class ToggleEditingEvent extends StoreEvent {
  final bool enableEditing;

  const ToggleEditingEvent({required this.enableEditing});
}
