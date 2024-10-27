import 'package:flutter/material.dart';
import 'package:ngu_app/features/journals/presentation/widgets/custom_journal_vouchers_pluto_table.dart';
import 'package:ngu_app/features/journals/presentation/widgets/journal_vouchers_tool_bar.dart';

class JournalVouchers extends StatefulWidget {
  const JournalVouchers({super.key});

  @override
  State<JournalVouchers> createState() => _JournalVouchersState();
}

class _JournalVouchersState extends State<JournalVouchers> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const JournalVouchersToolBar(),
        CustomJournalVouchersPlutoTable(),
      ],
    );
  }
}
