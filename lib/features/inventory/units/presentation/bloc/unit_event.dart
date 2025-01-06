part of 'unit_bloc.dart';

sealed class UnitEvent extends Equatable {
  const UnitEvent();

  @override
  List<Object> get props => [];
}

class GetUnitsEvent extends UnitEvent {}

class CreateUnitEvent extends UnitEvent {
  final UnitEntity unit;

  const CreateUnitEvent({required this.unit});
}

class UpdateUnitEvent extends UnitEvent {
  final UnitEntity unit;

  const UpdateUnitEvent({required this.unit});
}
