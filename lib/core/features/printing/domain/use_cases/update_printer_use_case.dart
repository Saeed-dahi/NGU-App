import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/features/printing/domain/entities/printer_entity.dart';
import 'package:ngu_app/core/features/printing/domain/repositories/printing_repository.dart';

class UpdatePrinterUseCase {
  final PrintingRepository printingRepository;

  UpdatePrinterUseCase({required this.printingRepository});

  Future<Either<Failure, PrinterEntity>> call(String printerType) async {
    return await printingRepository.updatePrinter(printerType);
  }
}
