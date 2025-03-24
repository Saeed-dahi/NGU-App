import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/printing/domain/entities/printer_entity.dart';
import 'package:ngu_app/core/features/printing/domain/repositories/printing_repository.dart';

class InsertPrinterUseCase {
  final PrintingRepository printingRepository;

  InsertPrinterUseCase({required this.printingRepository});

  Future<Either<Failure, PrinterEntity>> call(PrinterEntity printer) async {
    return await printingRepository.insertPrinter(printer);
  }
}
