import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/features/inventory/categories/presentation/widgets/custom_categories_pluto_table.dart';

class CategoriesTable extends StatefulWidget {
  const CategoriesTable({super.key});

  @override
  State<CategoriesTable> createState() => _CategoriesTableState();
}

class _CategoriesTableState extends State<CategoriesTable> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  Future<void> _refresh() async {}

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: _refresh,
      content: ListView(
        children: [
          CustomCategoriesPlutoTable()

          // return Center(
          //   child: MessageScreen(text: state.message),
          // );

          // return SizedBox(
          //   height: MediaQuery.sizeOf(context).height * 0.5,
          //   child: Center(
          //     child: Loaders.loading(),
          //   ),
          // );
        ],
      ),
    );
  }
}
