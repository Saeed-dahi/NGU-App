import 'package:equatable/equatable.dart';
import 'package:ngu_app/features/inventory/invoices/data/models/params/preview_invoice_item_model_params.dart';

class PreviewInvoiceItemEntityParams extends Equatable {
  final String query;
  final int? productUnitId;
  final int? accountId;

  const PreviewInvoiceItemEntityParams(
      {required this.query, this.productUnitId, this.accountId});

  PreviewInvoiceItemModelParams toModel() {
    return PreviewInvoiceItemModelParams(
        query: query, productUnitId: productUnitId, accountId: accountId);
  }

  @override
  List<Object?> get props => [query, productUnitId, accountId];
}
