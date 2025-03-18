import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/printing/domain/entities/printer_entity.dart';
import 'package:ngu_app/core/features/printing/domain/repositories/printing_repository.dart';

class PrintingRepositoriesImpl implements PrintingRepository {
  @override
  Future<Either<Failure, PrinterEntity>> addNewPrinter(PrinterEntity printer) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PrinterEntity>> getPrinter(String printerType) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PrinterEntity>>> getPrinters() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PrinterEntity>> updatePrinter(String printerType) {
    throw UnimplementedError();
  }
}
