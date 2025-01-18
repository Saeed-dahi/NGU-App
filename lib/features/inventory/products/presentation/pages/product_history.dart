import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductHistory extends StatefulWidget {
  const ProductHistory({super.key});

  @override
  State<ProductHistory> createState() => _ProductHistoryState();
}

class _ProductHistoryState extends State<ProductHistory> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('product_sts'.tr),
    );
  }
}
