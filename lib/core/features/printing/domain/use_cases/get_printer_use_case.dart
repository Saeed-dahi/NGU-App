import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/printing/domain/entities/printer_entity.dart';
import 'package:ngu_app/core/features/printing/domain/repositories/printing_repository.dart';

class GetPrinterUseCase {
  final PrintingRepository printingRepository;

  GetPrinterUseCase({required this.printingRepository});

  Future<Either<Failure, PrinterEntity>> call(String printerType) async {
    return await printingRepository.getPrinter(printerType);
  }
}
