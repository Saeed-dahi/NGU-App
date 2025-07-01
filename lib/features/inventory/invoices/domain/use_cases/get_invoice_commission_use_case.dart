import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_commission_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/repositories/invoice_repository.dart';

class GetInvoiceCommissionUseCase {
  final InvoiceRepository invoiceRepository;

  GetInvoiceCommissionUseCase({required this.invoiceRepository});

  Future<Either<Failure, InvoiceCommissionEntity>> call(int invoiceId) async {
    return await invoiceRepository.getInvoiceCommission(invoiceId);
  }
}
