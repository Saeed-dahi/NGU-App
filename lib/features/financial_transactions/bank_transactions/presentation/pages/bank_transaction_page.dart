import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/features/financial_transactions/bank_transactions/presentation/widgets/bank_transaction_fields.dart';
import 'package:ngu_app/features/financial_transactions/bank_transactions/presentation/widgets/bank_transaction_note_tool_bar.dart';

class BankTransactionPage extends StatefulWidget {
  const BankTransactionPage({super.key});

  @override
  State<BankTransactionPage> createState() => _BankTransactionPageState();
}

class _BankTransactionPageState extends State<BankTransactionPage> {
  bool enableEditing = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _pageBody();
  }

  Widget _pageBody() {
    return Column(
      children: [
        Text(
          'bank_transaction'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: Dimensions.primaryTextSize),
        ),
        BankTransactionToolBar(),
        const SizedBox(
          height: 20,
        ),
        BankTransactionFields(
          enableEditing: enableEditing,
        ),
      ],
    );
  }
}
