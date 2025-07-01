import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_commission_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_cost_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/params/invoice_items_entity_params.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/params/preview_invoice_item_entity_params.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/preview_invoice_item_entity.dart';

abstract class InvoiceRepository {
  Future<Either<Failure, List<InvoiceEntity>>> getAllInvoices(String type);
  Future<Either<Failure, InvoiceEntity>> showInvoice(
      int invoiceQuery, String? direction, String type, String? getBy);

  Future<Either<Failure, InvoiceEntity>> createInvoice(
      InvoiceEntity invoiceEntity, List<InvoiceItemsEntityParams> items);
  Future<Either<Failure, InvoiceEntity>> updateInvoice(
      InvoiceEntity invoiceEntity, List<InvoiceItemsEntityParams> items);

  Future<Either<Failure, InvoiceEntity>> getCreateInvoiceFormData(String type);

  Future<Either<Failure, PreviewInvoiceItemEntity>> previewInvoiceItem(
      PreviewInvoiceItemEntityParams params);

  Future<Either<Failure, InvoiceCostEntity>> getInvoiceCost(int invoiceId);

  Future<Either<Failure, InvoiceCommissionEntity>> getInvoiceCommission(
      int invoiceId);

  Future<Either<Failure, InvoiceCommissionEntity>> createInvoiceCommission(
      int invoiceId, InvoiceCommissionEntity invoiceCommissionEntity);
}
