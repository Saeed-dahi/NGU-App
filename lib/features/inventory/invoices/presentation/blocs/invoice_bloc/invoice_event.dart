part of 'invoice_bloc.dart';

sealed class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object> get props => [];
}

class GetAllInvoiceEvent extends InvoiceEvent {
  final String type;

  const GetAllInvoiceEvent({required this.type});
}

class ShowInvoiceEvent extends InvoiceEvent {
  final int invoiceId;
  final String? direction;
  final String type;

  const ShowInvoiceEvent(
      {required this.invoiceId, this.direction, required this.type});
}

class CreateInvoiceEvent extends InvoiceEvent {
  final InvoiceEntity invoice;

  const CreateInvoiceEvent({required this.invoice});
}

class UpdateInvoiceEvent extends InvoiceEvent {
  final InvoiceEntity invoice;

  const UpdateInvoiceEvent({required this.invoice});
}

class GetAccountsNameEvent extends InvoiceEvent {}

class GetCreateInvoiceFormData extends InvoiceEvent {
  final String type;

  const GetCreateInvoiceFormData({required this.type});
}
