import 'package:flutter/material.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/features/financial_transactions/visa_transactions/presentation/widgets/custom_visa_transactions_pluto_table.dart';

class BankTransactionsTablePage extends StatefulWidget {
  final int? accountId;
  const BankTransactionsTablePage({super.key, this.accountId});

  @override
  State<BankTransactionsTablePage> createState() =>
      _BankTransactionsTablePageState();
}

class _BankTransactionsTablePageState extends State<BankTransactionsTablePage> {
  @override
  void initState() {
    _initBloc();
    super.initState();
  }

  void _initBloc() {}

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refresh() async {}

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      child: ListView(
        children: [CustomVisaTransactionsPlutoTable()],
      ),
      onRefresh: () => _refresh(),
    );
  }
}
