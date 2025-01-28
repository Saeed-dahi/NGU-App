import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/repositories/invoice_repository.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  @override
  Future<Either<Failure, InvoiceEntity>> createInvoice(
      InvoiceEntity invoiceEntity) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<InvoiceEntity>>> getAllInvoices() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, InvoiceEntity>> showInvoice(
      int invoiceId, String? direction) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, InvoiceEntity>> updateInvoice(
      InvoiceEntity invoiceEntity) {
    throw UnimplementedError();
  }
}
