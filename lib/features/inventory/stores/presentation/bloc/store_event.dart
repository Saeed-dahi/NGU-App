part of 'store_bloc.dart';

sealed class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class GetStoresEvent extends StoreEvent {}

class CreateStoreEvent extends StoreEvent {
  final StoreEntity storeEntity;

  const CreateStoreEvent({required this.storeEntity});
}

class UpdateStoreEvent extends StoreEvent {
  final StoreEntity storeEntity;

  const UpdateStoreEvent({required this.storeEntity});
}
