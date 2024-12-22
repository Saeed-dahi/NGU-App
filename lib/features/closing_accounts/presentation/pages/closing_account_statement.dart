import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/dependency_injection/dependency_injection.dart';
import 'package:ngu_app/core/widgets/custom_refresh_indicator.dart';
import 'package:ngu_app/core/widgets/loaders.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';

import 'package:ngu_app/features/closing_accounts/domain/entities/closing_account_statement_entity.dart';
import 'package:ngu_app/features/closing_accounts/presentation/bloc/closing_accounts_bloc.dart';
import 'package:ngu_app/features/closing_accounts/presentation/widgets/custom_closing_account_pluto_table_statement.dart';

class ClosingAccountStatement extends StatefulWidget {
  const ClosingAccountStatement({super.key});

  @override
  State<ClosingAccountStatement> createState() =>
      _ClosingAccountStatementState();
}

class _ClosingAccountStatementState extends State<ClosingAccountStatement> {
  late final ClosingAccountsBloc _closingAccountsBloc;

  @override
  void initState() {
    _closingAccountsBloc = sl<ClosingAccountsBloc>()
      ..add(ClosingAccountStatementEvent());
    super.initState();
  }

  @override
  void dispose() {
    _closingAccountsBloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    _closingAccountsBloc.add(ClosingAccountStatementEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _closingAccountsBloc,
      child: CustomRefreshIndicator(
        onRefresh: _refresh,
        content: ListView(
          children: [
            BlocBuilder<ClosingAccountsBloc, ClosingAccountsState>(
              builder: (context, state) {
                if (state is ClosingAccountStatementState) {
                  return DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                            labelColor: Colors.black,
                            indicatorColor: AppColors.primaryColor,
                            tabs: [
                              Tab(text: 'trading'.tr),
                              Tab(text: 'profit_and_loss'.tr),
                              Tab(text: 'budget'.tr),
                            ]),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height,
                          child: TabBarView(children: [
                            _buildClosingAccountTable(context,
                                state.statement['trading']!, 'trading'),
                            _buildClosingAccountTable(
                                context,
                                state.statement['profit_loss']!,
                                'profit_and_loss'),
                            _buildClosingAccountTable(
                                context, state.statement['budget']!, 'budget'),
                          ]),
                        )
                      ],
                    ),
                  );
                }
                if (state is ErrorClosingAccountsState) {
                  return Center(
                    child: MessageScreen(text: state.message),
                  );
                }
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  child: Center(
                    child: Loaders.loading(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Column _buildClosingAccountTable(BuildContext context,
      ClosingAccountStatementEntity closingAccountStatementEntity, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.75,
              width: MediaQuery.sizeOf(context).width * 0.47,
              child: CustomClosingAccountPlutoTableStatement(
                accounts: closingAccountStatementEntity.revenueAccounts,
                accountsValue: closingAccountStatementEntity.revenueValue,
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.75,
              width: MediaQuery.sizeOf(context).width * 0.47,
              child: CustomClosingAccountPlutoTableStatement(
                accounts: closingAccountStatementEntity.expenseAccounts,
                accountsValue: closingAccountStatementEntity.expenseValue,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${key.tr}: ${closingAccountStatementEntity.value.toString()}',
            style: const TextStyle(
                fontSize: Dimensions.primaryTextSize,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
