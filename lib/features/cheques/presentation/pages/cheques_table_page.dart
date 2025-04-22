import 'package:flutter/material.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/features/cheques/presentation/widgets/custom_cheques_pluto_table.dart';

class ChequesTablePage extends StatefulWidget {
  const ChequesTablePage({super.key});

  @override
  State<ChequesTablePage> createState() => _ChequesTablePageState();
}

class _ChequesTablePageState extends State<ChequesTablePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refresh() async {}

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      child: ListView(
        children: [CustomChequesPlutoTable()],
      ),
      onRefresh: () => _refresh(),
    );
  }
}
