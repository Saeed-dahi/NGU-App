import 'package:flutter/material.dart';
import 'package:ngu_app/features/financial_transactions/visa_payment/presentation/widgets/custom_visa_payment_pluto_table.dart';
import 'package:ngu_app/features/financial_transactions/visa_payment/presentation/widgets/visa_payment_fields.dart';
import 'package:ngu_app/features/financial_transactions/visa_payment/presentation/widgets/visa_payment_tool_bar.dart';

class VisaPaymentPage extends StatefulWidget {
  const VisaPaymentPage({super.key});

  @override
  State<VisaPaymentPage> createState() => _VisaPaymentPageState();
}

class _VisaPaymentPageState extends State<VisaPaymentPage> {
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
        VisaPaymentToolBar(),
        VisaPaymentFields(
          enableEditing: enableEditing,
        ),
        CustomVisaPaymentPlutoTable(),
      ],
    );
  }
}
