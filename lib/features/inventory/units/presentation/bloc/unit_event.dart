part of 'unit_bloc.dart';

sealed class UnitEvent extends Equatable {
  const UnitEvent();

  @override
  List<Object> get props => [];
}

class GetUnitsEvent extends UnitEvent {
  final int? productId;
  final bool? showProductUnits;

  const GetUnitsEvent({this.productId, this.showProductUnits});
}

class CreateUnitEvent extends UnitEvent {
  final UnitEntity unit;

  const CreateUnitEvent({required this.unit});
}

class UpdateUnitEvent extends UnitEvent {
  final UnitEntity unit;

  const UpdateUnitEvent({required this.unit});
}
