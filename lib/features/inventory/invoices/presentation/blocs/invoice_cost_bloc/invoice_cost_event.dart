part of 'invoice_cost_bloc.dart';

sealed class InvoiceCostEvent extends Equatable {
  const InvoiceCostEvent();

  @override
  List<Object> get props => [];
}

class GetInvoiceCostEvent extends InvoiceCostEvent {
  final int invoiceId;

  const GetInvoiceCostEvent({required this.invoiceId});
}
