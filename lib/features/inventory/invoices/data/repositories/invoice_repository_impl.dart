import 'package:dartz/dartz.dart';
import 'package:ngu_app/core/error/failures.dart';
import 'package:ngu_app/core/helper/api_helper.dart';
import 'package:ngu_app/features/inventory/invoices/data/data_sources/invoice_data_source.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/params/invoice_items_model_params.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/params/invoice_items_entity_params.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/params/preview_invoice_item_entity_params.dart';
import 'package:ngu_app/features/inventory/invoices/domain/entities/preview_invoice_item_entity.dart';
import 'package:ngu_app/features/inventory/invoices/domain/repositories/invoice_repository.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final ApiHelper apiHelper;
  final InvoiceDataSource invoiceDataSource;

  InvoiceRepositoryImpl(
      {required this.apiHelper, required this.invoiceDataSource});

  @override
  Future<Either<Failure, List<InvoiceEntity>>> getAllInvoices(
      String type) async {
    return await apiHelper
        .safeApiCall(() => invoiceDataSource.getAllInvoices(type));
  }

  @override
  Future<Either<Failure, InvoiceEntity>> showInvoice(
      int invoiceQuery, String? direction, String type, String? getBy) async {
    return await apiHelper.safeApiCall(() => invoiceDataSource.showInvoice(
        invoiceQuery, direction, type, getBy ?? 'id'));
  }

  @override
  Future<Either<Failure, InvoiceEntity>> createInvoice(
      InvoiceEntity invoiceEntity, List<InvoiceItemsEntityParams> items) async {
    return await apiHelper.safeApiCall(() => invoiceDataSource.createInvoice(
        invoiceEntity.toModel(), _getItemsModel(items)));
  }

  @override
  Future<Either<Failure, InvoiceEntity>> updateInvoice(
      InvoiceEntity invoiceEntity, List<InvoiceItemsEntityParams> items) async {
    return await apiHelper.safeApiCall(() => invoiceDataSource.updateInvoice(
        invoiceEntity.toModel(), _getItemsModel(items)));
  }

  @override
  Future<Either<Failure, InvoiceEntity>> getCreateInvoiceFormData(
      String type) async {
    return await apiHelper
        .safeApiCall(() => invoiceDataSource.getCreateInvoiceFormData(type));
  }

  @override
  Future<Either<Failure, PreviewInvoiceItemEntity>> previewInvoiceItem(
      PreviewInvoiceItemEntityParams params) async {
    return await apiHelper.safeApiCall(
        () => invoiceDataSource.previewInvoiceItem(params.toModel()));
  }

  List<InvoiceItemsModelParams> _getItemsModel(
      List<InvoiceItemsEntityParams> items) {
    return items.map((item) {
      return item.toModel();
    }).toList();
  }
}
