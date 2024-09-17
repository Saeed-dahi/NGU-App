import 'package:flutter/material.dart';
import 'package:ngu_app/core/widgets/tables/custom_pluto_table.dart';

class AccountsTable extends StatelessWidget {
  const AccountsTable({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: CustomPlutoTable(),
    );
  }
}
