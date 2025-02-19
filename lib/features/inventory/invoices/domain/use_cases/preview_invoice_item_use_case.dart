import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/params/preview_invoice_item_entity_params.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/preview_invoice_item_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/repositories/invoice_repository.dart';

class PreviewInvoiceItemUseCase {
  final InvoiceRepository invoiceRepository;

  PreviewInvoiceItemUseCase({required this.invoiceRepository});

  Future<Either<Failure, PreviewInvoiceItemEntity>> call(
      PreviewInvoiceItemEntityParams params) async {
    return invoiceRepository.previewInvoiceItem(params);
  }
}
