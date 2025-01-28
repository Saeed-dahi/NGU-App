part of 'invoice_bloc.dart';

sealed class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object> get props => [];
}

class GetAllInvoiceEvent extends InvoiceEvent {}

class ShowInvoiceEvent extends InvoiceEvent {
  final int invoiceId;
  final String? direction;

  const ShowInvoiceEvent({required this.invoiceId, this.direction});
}

class CreateInvoiceEvent extends InvoiceEvent {
  final InvoiceEntity invoice;

  const CreateInvoiceEvent({required this.invoice});
}

class UpdateInvoiceEvent extends InvoiceEvent {
  final InvoiceEntity invoice;

  const UpdateInvoiceEvent({required this.invoice});
}
