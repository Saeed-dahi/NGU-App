import 'package:equatable/equatable.dart';

class InvoiceCostEntity extends Equatable {
  final double? totalAmount;
  final double? costTotal;
  final double? profitTotal;
  final List<InvoiceCostEntityItems>? items;

  const InvoiceCostEntity({
    required this.totalAmount,
    required this.profitTotal,
    required this.costTotal,
    required this.items,
  });

  @override
  List<Object?> get props => [
        totalAmount,
        costTotal,
        profitTotal,
        items,
      ];
}

class InvoiceCostEntityItems extends Equatable {
  final String? productName;
  final String? unitName;
  final double? price;
  final double? lastPurchasePrice;
  final String? lastPurchaseDate;
  final double? difference;

  const InvoiceCostEntityItems(
      {required this.productName,
      required this.unitName,
      required this.price,
      required this.lastPurchasePrice,
      required this.lastPurchaseDate,
      required this.difference});

  @override
  List<Object?> get props => [
        productName,
        unitName,
        price,
        lastPurchasePrice,
        lastPurchaseDate,
        difference
      ];
}
