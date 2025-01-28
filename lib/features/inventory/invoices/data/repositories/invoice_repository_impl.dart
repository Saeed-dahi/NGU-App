import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/inventory/invoices/data/data_sources/invoice_data_source.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/repositories/invoice_repository.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final ApiHelper apiHelper;
  final InvoiceDataSource invoiceDataSource;

  InvoiceRepositoryImpl(
      {required this.apiHelper, required this.invoiceDataSource});

  @override
  Future<Either<Failure, List<InvoiceEntity>>> getAllInvoices() async {
    return await apiHelper
        .safeApiCall(() => invoiceDataSource.getAllInvoices());
  }

  @override
  Future<Either<Failure, InvoiceEntity>> showInvoice(
      int invoiceId, String? direction) async {
    return await apiHelper
        .safeApiCall(() => invoiceDataSource.showInvoice(invoiceId, direction));
  }

  @override
  Future<Either<Failure, InvoiceEntity>> createInvoice(
      InvoiceEntity invoiceEntity) async {
    return await apiHelper.safeApiCall(
        () => invoiceDataSource.createInvoice(invoiceEntity.toModel()));
  }

  @override
  Future<Either<Failure, InvoiceEntity>> updateInvoice(
      InvoiceEntity invoiceEntity) async {
    return await apiHelper.safeApiCall(
        () => invoiceDataSource.updateInvoice(invoiceEntity.toModel()));
  }
}
