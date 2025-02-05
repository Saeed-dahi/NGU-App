import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';

abstract class InvoiceRepository {
  Future<Either<Failure, List<InvoiceEntity>>> getAllInvoices(String type);
  Future<Either<Failure, InvoiceEntity>> showInvoice(
      int invoiceId, String? direction, String type);

  Future<Either<Failure, InvoiceEntity>> createInvoice(
      InvoiceEntity invoiceEntity);
  Future<Either<Failure, InvoiceEntity>> updateInvoice(
      InvoiceEntity invoiceEntity);
}
