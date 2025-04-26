import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/utils/enums.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/cheques/domain/entities/cheque_entity.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomChequesPlutoTable extends StatelessWidget {
  late PlutoGridController _plutoGridController = PlutoGridController();
  final List<ChequeEntity> cheques;

  CustomChequesPlutoTable({super.key, required this.cheques});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.8,
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: PlutoGridMode.readOnly,
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        columns: _buildColumns(context),
        rows: _buildRows().toList(),
        onLoaded: (PlutoGridOnLoadedEvent event) {
          _plutoGridController =
              PlutoGridController(stateManager: event.stateManager);
        },
      ),
    );
  }

  List<PlutoColumn> _buildColumns(BuildContext context) {
    return [
      PlutoColumn(
        title: 'debit'.tr,
        field: 'debit',
        type: PlutoColumnType.text(),
        footerRenderer: (context) {
          return const Center(
            child: Text(
              '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
      PlutoColumn(
          title: 'credit'.tr,
          field: 'credit',
          type: PlutoColumnType.text(),
          footerRenderer: (context) {
            return const Center(
              child: Text(
                '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }),
      PlutoColumn(
        title: 'issued_from_account'.tr,
        field: 'issued_from_account',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'target_bank_account'.tr,
        field: 'target_bank_account',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'issued_to_account'.tr,
        field: 'issued_to_account',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'description'.tr,
        field: 'description',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'due_date'.tr,
        field: 'due_date',
        type: PlutoColumnType.date(),
      ),
    ];
  }

  Iterable<PlutoRow> _buildRows() {
    return cheques.map(
      (cheque) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: cheque.id,
          cells: {
            'debit': PlutoCell(
                value: cheque.nature == ChequeNature.incoming.name
                    ? cheque.amount
                    : ''),
            'credit': PlutoCell(
                value: cheque.nature == ChequeNature.outgoing.name
                    ? cheque.amount
                    : ''),
            'issued_from_account':
                PlutoCell(value: cheque.issuedFromAccount!.arName),
            'target_bank_account':
                PlutoCell(value: cheque.targetBankAccount!.arName),
            'issued_to_account':
                PlutoCell(value: cheque.issuedToAccount!.arName),
            'description': PlutoCell(value: cheque.notes),
            'due_date': PlutoCell(value: cheque.dueDate),
          },
        );
      },
    );
  }
}
