import 'package:flutter/material.dart';
import 'package:ngu_app/features/financial_transactions/visa_transactions/presentation/widgets/custom_visa_transaction_pluto_table.dart';
import 'package:ngu_app/features/financial_transactions/visa_transactions/presentation/widgets/visa_transaction_fields.dart';
import 'package:ngu_app/features/financial_transactions/visa_transactions/presentation/widgets/visa_transaction_note_tool_bar.dart';

class VisaTransactionPage extends StatefulWidget {
  const VisaTransactionPage({super.key});

  @override
  State<VisaTransactionPage> createState() => _VisaTransactionPageState();
}

class _VisaTransactionPageState extends State<VisaTransactionPage> {
  bool enableEditing = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _pageBody();
  }

  ListView _pageBody() {
    return ListView(
      children: [
        VisaTransactionToolBar(),
        VisaTransactionFields(
          enableEditing: enableEditing,
        ),
        CustomVisaTransactionPlutoTable(),
      ],
    );
  }
}
