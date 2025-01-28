import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/repositories/invoice_repository.dart';

class ShowInvoiceUseCase {
  final InvoiceRepository invoiceRepository;

  ShowInvoiceUseCase({required this.invoiceRepository});

  Future<Either<Failure, InvoiceEntity>> call(
      int invoiceId, String? direction) async {
    return await invoiceRepository.showInvoice(invoiceId, direction);
  }
}
