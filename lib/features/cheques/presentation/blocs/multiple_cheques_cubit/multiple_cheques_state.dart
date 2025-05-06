part of 'multiple_cheques_cubit.dart';

sealed class MultipleChequesState extends Equatable {
  const MultipleChequesState();

  @override
  List<Object> get props => [];
}

final class MultipleChequesInitial extends MultipleChequesState {}

class ChangeSelectedPaymentWay extends MultipleChequesState {
  final String selectedValue;

  const ChangeSelectedPaymentWay({required this.selectedValue});

  @override
  List<Object> get props => [selectedValue];
}
