import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/printing/domain/entities/printer_entity.dart';

abstract class PrintingRepository {
  Future<Either<Failure, PrinterEntity>> getPrinter(String printerType);
  Future<Either<Failure, List<PrinterEntity>>> getPrinters();
  Future<Either<Failure, PrinterEntity>> addNewPrinter(PrinterEntity printer);
  Future<Either<Failure, PrinterEntity>> updatePrinter(String printerType);
}
