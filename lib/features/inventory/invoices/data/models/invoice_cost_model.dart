import 'package:ngu_app/features/inventory/invoices/domain/entities/invoice_cost_entity.dart';

class InvoiceCostModel extends InvoiceCostEntity {
  const InvoiceCostModel(
      {super.totalAmount, super.profitTotal, super.costTotal, super.items});

  factory InvoiceCostModel.fromJson(Map<String, dynamic> json) {
    return InvoiceCostModel(
        totalAmount: double.tryParse(json['invoice_total'].toString()),
        costTotal: double.tryParse(json['cost_total'].toString()),
        profitTotal: double.tryParse(json['profit_total'].toString()),
        items: json['items']
            .map<InvoiceCostModelItems>(
                (item) => InvoiceCostModelItems.fromJson(item))
            .toList());
  }
}

class InvoiceCostModelItems extends InvoiceCostEntityItems {
  const InvoiceCostModelItems(
      {super.productName,
      super.unitName,
      super.price,
      super.lastPurchasePrice,
      super.lastPurchaseDate,
      super.difference});

  factory InvoiceCostModelItems.fromJson(Map<String, dynamic> json) {
    return InvoiceCostModelItems(
        productName: json['product_name'],
        unitName: json['unit_name'],
        price: double.tryParse(json['invoice_item_price'].toString()),
        lastPurchasePrice:
            double.tryParse(json['last_purchase_price'].toString()),
        lastPurchaseDate: json['last_purchase_date'],
        difference: double.tryParse(json['difference'].toString()));
  }
}
