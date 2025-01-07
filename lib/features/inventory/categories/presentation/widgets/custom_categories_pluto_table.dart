import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/inventory/categories/domain/entities/category_entity.dart';
import 'package:ngu_app/features/inventory/categories/presentation/bloc/category_bloc.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomCategoriesPlutoTable extends StatelessWidget {
  late PlutoGridController _plutoGridController = PlutoGridController();
  final List<CategoryEntity> stores;

  CustomCategoriesPlutoTable({super.key, required this.stores});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.5,
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: PlutoGridMode.readOnly,
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        columns: _buildColumns(context),
        rows: _buildRows().toList(),
        showDefaultHeader: false,
        customEnterKeyAction: () {
          Get.back(result: {
            'ar_name': _plutoGridController
                .stateManager!.currentRow!.cells['ar_name']!.value,
            'en_name': _plutoGridController
                .stateManager!.currentRow!.cells['en_name']!.value,
            'category_id': _plutoGridController.stateManager!.currentRow!.data
          });
        },
        onLoaded: (PlutoGridOnLoadedEvent event) {
          _plutoGridController =
              PlutoGridController(stateManager: event.stateManager);
          context.read<CategoryBloc>().plutoGridController =
              _plutoGridController;
        },
      ),
    );
  }

  List<PlutoColumn> _buildColumns(BuildContext context) {
    return [
      PlutoColumn(
        title: 'ar_name'.tr,
        field: 'ar_name',
        enableFilterMenuItem: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'en_name'.tr,
        field: 'en_name',
        enableFilterMenuItem: true,
        enableContextMenu: false,
        width: MediaQuery.sizeOf(context).width * 0.4,
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'description'.tr,
        field: 'description',
        enableFilterMenuItem: false,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
      ),
    ];
  }

  Iterable<PlutoRow> _buildRows() {
    return stores.map(
      (account) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: account.id,
          cells: {
            'ar_name': PlutoCell(value: account.arName),
            'en_name': PlutoCell(value: account.enName),
            'description': PlutoCell(value: account.description),
          },
        );
      },
    );
  }
}
