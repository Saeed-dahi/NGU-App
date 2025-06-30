part of 'invoice_cost_bloc.dart';

sealed class InvoiceCostState extends Equatable {
  const InvoiceCostState();

  @override
  List<Object> get props => [];
}

final class InvoiceCostInitial extends InvoiceCostState {}

class LoadedInvoiceCostState extends InvoiceCostState {
  final InvoiceCostEntity invoiceCostEntity;

  const LoadedInvoiceCostState({required this.invoiceCostEntity});
}

class LoadingInvoiceCostState extends InvoiceCostState {}

class ErrorInvoiceCostState extends InvoiceCostState {
  final String message;

  const ErrorInvoiceCostState({required this.message});

  @override
  List<Object> get props => [message];
}
