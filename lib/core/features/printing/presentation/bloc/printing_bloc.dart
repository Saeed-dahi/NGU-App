import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngu_app/core/features/printing/domain/use_cases/add_new_printer_use_case.dart';
import 'package:ngu_app/core/features/printing/domain/use_cases/get_printer_use_case.dart';
import 'package:ngu_app/core/features/printing/domain/use_cases/get_printers_use_case.dart';
import 'package:ngu_app/core/features/printing/domain/use_cases/update_printer_use_case.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart';

part 'printing_event.dart';
part 'printing_state.dart';

class PrintingBloc extends Bloc<PrintingEvent, PrintingState> {
  final GetPrinterUseCase getPrinterUseCase;
  final GetPrintersUseCase getPrintersUseCase;
  final AddNewPrinterUseCase addNewPrinterUseCase;
  final UpdatePrinterUseCase updatePrinterUseCase;

  PrintingBloc(
      {required this.getPrinterUseCase,
      required this.getPrintersUseCase,
      required this.addNewPrinterUseCase,
      required this.updatePrinterUseCase})
      : super(PrintingInitial()) {
    on<PrintingEvent>((event, emit) {});
  }

  Future<Font> getCustomFont() async {
    final fontData =
        await rootBundle.load('assets/fonts/tajawal/Tajawal-ExtraBold.ttf');
    final ttf = pw.Font.ttf(fontData);

    return ttf;
  }
}
