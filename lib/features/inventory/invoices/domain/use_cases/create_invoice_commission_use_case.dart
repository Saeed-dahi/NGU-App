import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_commission_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/repositories/invoice_repository.dart';

class CreateInvoiceCommissionUseCase {
  final InvoiceRepository invoiceRepository;

  CreateInvoiceCommissionUseCase({required this.invoiceRepository});

  Future<Either<Failure, InvoiceCommissionEntity>> call(
      int invoiceId, InvoiceCommissionEntity invoiceCommissionEntity) async {
    return await invoiceRepository.createInvoiceCommission(
        invoiceId, invoiceCommissionEntity);
  }
}
