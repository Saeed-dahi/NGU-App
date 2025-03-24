import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/features/printing/domain/entities/printer_entity.dart';
import 'package:ngu_app/core/features/printing/domain/use_cases/insert_printer_use_case.dart';
import 'package:ngu_app/core/features/printing/domain/use_cases/get_printer_use_case.dart';
import 'package:ngu_app/core/features/printing/domain/use_cases/get_printers_use_case.dart';
import 'package:ngu_app/core/features/printing/domain/use_cases/update_printer_use_case.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/snack_bar.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

part 'printing_event.dart';
part 'printing_state.dart';

class PrintingBloc extends Bloc<PrintingEvent, PrintingState> {
  final GetPrinterUseCase getPrinterUseCase;
  final GetPrintersUseCase getPrintersUseCase;
  final InsertPrinterUseCase addNewPrinterUseCase;
  final UpdatePrinterUseCase updatePrinterUseCase;

  Printer? receiptPrinter;
  Printer? taxInvoicePrinter;

  PrintingBloc(
      {required this.getPrinterUseCase,
      required this.getPrintersUseCase,
      required this.addNewPrinterUseCase,
      required this.updatePrinterUseCase})
      : super(PrintingInitial()) {
    on<GetPrinterEvent>(_getPrinter);
    on<InsertPrinterEvent>(_insertPrinter);
    on<UpdatePrinterEvent>(_updatePrinter);
  }

  Future<Font> getCustomFont() async {
    final fontData =
        await rootBundle.load('assets/fonts/tajawal/Tajawal-ExtraBold.ttf');
    final ttf = pw.Font.ttf(fontData);

    return ttf;
  }

  FutureOr<void> _getPrinter(
      GetPrinterEvent event, Emitter<PrintingState> emit) async {
    final result = await getPrinterUseCase(event.printerType);

    result.fold((failure) {
      ShowSnackBar.showValidationSnackbar(messages: [failure.errors['error']]);
    }, (data) {
      _setPrinterByPrinterType(data, event.printerType);
      emit(LoadedPrinterState(printerEntity: data));
    });
  }

  FutureOr<void> _insertPrinter(
      InsertPrinterEvent event, Emitter<PrintingState> emit) async {
    print('insert');
    final result = await addNewPrinterUseCase(event.printer);
    print(result);
    result.fold((failure) {
      ShowSnackBar.showValidationSnackbar(messages: [failure.errors['error']]);
    }, (data) {
      _setPrinterByPrinterType(data, data.printerType);
      emit(LoadedPrinterState(printerEntity: data));
    });
  }

  FutureOr<void> _updatePrinter(
      UpdatePrinterEvent event, Emitter<PrintingState> emit) async {
    print('update');
    final result = await updatePrinterUseCase(event.printer);
    print(result);
    result.fold((failure) {
      ShowSnackBar.showValidationSnackbar(messages: [failure.errors['error']]);
    }, (data) {
      _setPrinterByPrinterType(data, data.printerType);
      emit(LoadedPrinterState(printerEntity: data));
    });
  }

  pickPrinter(BuildContext context, String printerType, bool isExisting) async {
    Printer? printer = await Printing.pickPrinter(context: context);
    if (printer != null) {
      PrinterEntity printerEntity = PrinterEntity(
          url: printer.url, name: printer.name, printerType: printerType);
      isExisting
          ? add(UpdatePrinterEvent(printer: printerEntity))
          : add(InsertPrinterEvent(printer: printerEntity));
    }
  }

  void _setPrinterByPrinterType(
      PrinterEntity printerEntity, String printerType) {
    Printer? p = Printer(
      url: printerEntity.url,
      name: printerEntity.name,
    );
    printerType == PrinterType.receipt.name
        ? receiptPrinter = p
        : taxInvoicePrinter = p;
  }
}
