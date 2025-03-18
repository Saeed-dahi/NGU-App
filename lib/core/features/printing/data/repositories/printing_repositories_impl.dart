import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/printing/data/data_sources/printing_local_data_sources.dart';
import 'package:ngu_app/core/features/printing/domain/entities/printer_entity.dart';
import 'package:ngu_app/core/features/printing/domain/repositories/printing_repository.dart';
import 'package:ngu_app/core/helper/data_base_helper.dart';

class PrintingRepositoryImpl implements PrintingRepository {
  final PrintingDataSource printingDataSource;
  final DataBaseHelper dataBaseHelper;

  PrintingRepositoryImpl(
      {required this.printingDataSource, required this.dataBaseHelper});

  @override
  Future<Either<Failure, List<PrinterEntity>>> getPrinters() async {
    return dataBaseHelper
        .safeDataBaseConnection(() => printingDataSource.getPrinters());
  }

  @override
  Future<Either<Failure, PrinterEntity>> getPrinter(String printerType) async {
    return dataBaseHelper.safeDataBaseConnection(
        () => printingDataSource.getPrinter(printerType));
  }

  @override
  Future<Either<Failure, PrinterEntity>> addNewPrinter(
      PrinterEntity printer) async {
    return dataBaseHelper.safeDataBaseConnection(
        () => printingDataSource.addNewPrinter(printer.toPrinterModel()));
  }

  @override
  Future<Either<Failure, PrinterEntity>> updatePrinter(
      String printerType) async {
    return dataBaseHelper.safeDataBaseConnection(
        () => printingDataSource.updatePrinter(printerType));
  }
}
