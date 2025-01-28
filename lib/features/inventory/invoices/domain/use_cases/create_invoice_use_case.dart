import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/repositories/invoice_repository.dart';

class CreateInvoiceUseCase {
  final InvoiceRepository invoiceRepository;

  CreateInvoiceUseCase({required this.invoiceRepository});

  Future<Either<Failure, InvoiceEntity>> call(InvoiceEntity invoice) async {
    return await invoiceRepository.createInvoice(invoice);
  }
}
