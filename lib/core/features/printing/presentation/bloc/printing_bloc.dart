import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart';

part 'printing_event.dart';
part 'printing_state.dart';

class PrintingBloc extends Bloc<PrintingEvent, PrintingState> {
  PrintingBloc() : super(PrintingInitial()) {
    on<PrintingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  Future<Font> getCustomFont() async {
    final fontData =
        await rootBundle.load('assets/fonts/tajawal/Tajawal-ExtraBold.ttf');
    final ttf = pw.Font.ttf(fontData);

    return ttf;
  }
}
