import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/features/inventory/categories/presentation/widgets/custom_categories_pluto_table.dart';
import 'package:ngu_app/features/inventory/units/presentation/widgets/custom_units_pluto_table.dart';

class UnitsTable extends StatefulWidget {
  const UnitsTable({super.key});

  @override
  State<UnitsTable> createState() => _CategoriesTableState();
}

class _CategoriesTableState extends State<UnitsTable> {
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
          CustomUnitsPlutoTable()

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
