import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/params/invoice_items_entity_params.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/preview_invoice_item_entity.dart';

abstract class InvoiceRepository {
  Future<Either<Failure, List<InvoiceEntity>>> getAllInvoices(String type);
  Future<Either<Failure, InvoiceEntity>> showInvoice(
      int invoiceId, String? direction, String type);

  Future<Either<Failure, InvoiceEntity>> createInvoice(
      InvoiceEntity invoiceEntity, List<InvoiceItemsEntityParams> items);
  Future<Either<Failure, InvoiceEntity>> updateInvoice(
      InvoiceEntity invoiceEntity, List<InvoiceItemsEntityParams> items);

  Future<Either<Failure, InvoiceEntity>> getCreateInvoiceFormData(String type);

  Future<Either<Failure, PreviewInvoiceItemEntity>> previewInvoiceItem(
      String query, String? accountId, String productUnitId);
}
