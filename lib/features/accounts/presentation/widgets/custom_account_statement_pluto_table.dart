import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/lang/localization_service.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/features/accounts/domain/entities/account_statement_entity.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomAccountStatementPlutoTable extends StatelessWidget {
  final AccountStatementEntity accountStatement;

  const CustomAccountStatementPlutoTable({
    super.key,
    required this.accountStatement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.85,
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      child: PlutoGrid(
        createFooter: (stateManager) {
          return _customFooter(context);
        },
        configuration: _tableConfig(),
        mode: PlutoGridMode.readOnly,
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        columns: _buildColumns(context),
        rows: _buildRows().toList(),
        onLoaded: (PlutoGridOnLoadedEvent event) {},
      ),
    );
  }

  Padding _customFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text(
              accountStatement.debitBalance.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text(
              accountStatement.creditBalance.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Text(
              '${'balance'.tr}: ${accountStatement.debitBalance - accountStatement.creditBalance}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  List<PlutoColumn> _buildColumns(BuildContext context) {
    return [
      PlutoColumn(
        title: 'debit'.tr,
        field: 'debit',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'credit'.tr,
        field: 'credit',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'balance'.tr,
        field: 'account_new_balance',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'description'.tr,
        field: 'description',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'document_number'.tr,
        field: 'document_number',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'created_at'.tr,
        field: 'created_at',
        type: PlutoColumnType.text(),
      ),
    ];
  }

  Iterable<PlutoRow> _buildRows() {
    return accountStatement.transactions.map(
      (sts) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: sts.id,
          cells: {
            'debit': PlutoCell(
                value: sts.type == AccountNature.debit.name ? sts.amount : ''),
            'credit': PlutoCell(
                value: sts.type == AccountNature.credit.name ? sts.amount : ''),
            'account_new_balance': PlutoCell(value: sts.accountNewBalance),
            'description': PlutoCell(value: sts.description),
            'document_number': PlutoCell(value: sts.documentNumber),
            'created_at': PlutoCell(value: sts.createdAt),
          },
        );
      },
    );
  }

  PlutoGridConfiguration _tableConfig() {
    return PlutoGridConfiguration(
      localeText: LocalizationService.isArabic
          ? const PlutoGridLocaleText.arabic()
          : const PlutoGridLocaleText(),
      columnFilter: const PlutoGridColumnFilterConfig(),
      scrollbar: const PlutoGridScrollbarConfig(
          scrollBarColor: AppColors.primaryColor),
      columnSize: const PlutoGridColumnSizeConfig(
          autoSizeMode: PlutoAutoSizeMode.scale),
      tabKeyAction: PlutoGridTabKeyAction.moveToNextOnEdge,
      style: PlutoGridStyleConfig(
        rowCheckedColor: AppColors.primaryColorLow.withOpacity(0.3),
        gridBorderColor: AppColors.primaryColor,
        rowHoveredColor: AppColors.transparent,
        enableGridBorderShadow: true,
        enableRowHoverColor: true,
        gridBorderRadius: BorderRadius.circular(
          Dimensions.borderRadius,
        ),
      ),
    );
  }
}
