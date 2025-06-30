import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_cost_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/repositories/invoice_repository.dart';

class GetInvoiceCostUseCase {
  final InvoiceRepository invoiceRepository;

  GetInvoiceCostUseCase({required this.invoiceRepository});

  Future<Either<Failure, InvoiceCostEntity>> call(int invoiceId) async {
    return await invoiceRepository.getInvoiceCost(invoiceId);
  }
}
