import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/features/inventory/stores/presentation/widgets/custom_stores_pluto_table.dart';

class StoresTable extends StatefulWidget {
  const StoresTable({super.key});

  @override
  State<StoresTable> createState() => _StoresTableState();
}

class _StoresTableState extends State<StoresTable> {
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
          CustomStoresPlutoTable()

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
