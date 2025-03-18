part of 'printing_bloc.dart';

sealed class PrintingEvent extends Equatable {
  const PrintingEvent();

  @override
  List<Object> get props => [];
}

class GetPrinterEvent extends PrintingEvent {
  final String printerType;

  const GetPrinterEvent({required this.printerType});
}

class GetPrintersEvent extends PrintingEvent {}

class InsertPrinterEvent extends PrintingEvent {
  final PrinterEntity printer;

  const InsertPrinterEvent({required this.printer});
}

class UpdatePrinterEvent extends PrintingEvent {
  final String printerType;

  const UpdatePrinterEvent({required this.printerType});
}
