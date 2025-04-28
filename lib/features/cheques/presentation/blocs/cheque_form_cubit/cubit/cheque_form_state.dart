part of 'cheque_form_cubit.dart';

sealed class ChequeFormState extends Equatable {
  const ChequeFormState();

  @override
  List<Object> get props => [];
}

final class ChequeFormInitial extends ChequeFormState {}
