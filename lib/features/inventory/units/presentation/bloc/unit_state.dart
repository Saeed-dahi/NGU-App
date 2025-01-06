part of 'unit_bloc.dart';

sealed class UnitState extends Equatable {
  const UnitState();

  @override
  List<Object> get props => [];
}

final class UnitInitial extends UnitState {}

class LoadedUnitsState extends UnitState {
  final List<UnitEntity> units;

  const LoadedUnitsState({required this.units});

  @override
  List<Object> get props => [units];
}

class LoadingUnitsState extends UnitState {}

class ErrorUnitsState extends UnitState {
  final String message;

  const ErrorUnitsState({required this.message});
  @override
  List<Object> get props => [message];
}

class ValidationUnitState extends UnitState {
  final Map<String, dynamic> errors;

  const ValidationUnitState({required this.errors});

  @override
  List<Object> get props => [errors];
}
