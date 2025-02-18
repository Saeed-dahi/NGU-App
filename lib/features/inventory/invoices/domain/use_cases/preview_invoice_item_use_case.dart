import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/preview_invoice_item_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/repositories/invoice_repository.dart';

class PreviewInvoiceItemUseCase {
  final InvoiceRepository invoiceRepository;

  PreviewInvoiceItemUseCase({required this.invoiceRepository});

  Future<Either<Failure, PreviewInvoiceItemEntity>> call(
      String query, String? accountId, String productUnitId) async {
    return invoiceRepository.previewInvoiceItem(
        query, accountId, productUnitId);
  }
}
