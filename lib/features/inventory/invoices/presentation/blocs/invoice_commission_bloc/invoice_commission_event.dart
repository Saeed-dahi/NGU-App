part of 'invoice_commission_bloc.dart';

sealed class InvoiceCommissionEvent extends Equatable {
  const InvoiceCommissionEvent();

  @override
  List<Object> get props => [];
}

class GetInvoiceCommissionEvent extends InvoiceCommissionEvent {
  final int invoiceId;

  const GetInvoiceCommissionEvent({required this.invoiceId});

  @override
  List<Object> get props => [invoiceId];
}

class CreateInvoiceCommissionEvent extends InvoiceCommissionEvent {
  final int invoiceId;
  final InvoiceCommissionEntity invoiceCommissionEntity;

  const CreateInvoiceCommissionEvent(
      {required this.invoiceId, required this.invoiceCommissionEntity});

  @override
  List<Object> get props => [invoiceId, invoiceCommissionEntity];
}
