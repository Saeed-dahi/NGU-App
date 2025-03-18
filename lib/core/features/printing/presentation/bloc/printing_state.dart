part of 'printing_bloc.dart';

sealed class PrintingState extends Equatable {
  const PrintingState();

  @override
  List<Object> get props => [];
}

final class PrintingInitial extends PrintingState {}

class LoadedPrinterState extends PrintingState {
  final PrinterEntity printerEntity;

  const LoadedPrinterState({required this.printerEntity});
  @override
  List<Object> get props => [printerEntity];
}

class LoadingPrinterState extends PrintingState {}

class ErrorPrinterState extends PrintingState {
  final String error;

  const ErrorPrinterState({required this.error});
  @override
  List<Object> get props => [error];
}
