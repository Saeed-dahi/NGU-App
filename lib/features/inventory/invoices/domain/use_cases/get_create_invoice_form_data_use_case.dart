import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/repositories/invoice_repository.dart';

class GetCreateInvoiceFormDataUseCase {
  final InvoiceRepository invoiceRepository;

  GetCreateInvoiceFormDataUseCase({required this.invoiceRepository});

  Future<Either<Failure, InvoiceEntity>> call(String type) async {
    return await invoiceRepository.getCreateInvoiceFormData(type);
  }
}
