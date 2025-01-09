import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/app_strings.dart';
import 'package:ngu_app/core/widgets/message_screen.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/custom_pluto_grid.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/pluto_grid_controller.dart';
import 'package:ngu_app/features/inventory/products/domain/entities/product_entity.dart';
import 'package:ngu_app/features/inventory/products/presentation/bloc/product_bloc.dart';
import 'package:ngu_app/features/inventory/products/presentation/widgets/product_option_menu.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class CustomProductPlutoTable extends StatelessWidget {
  final List<ProductEntity> products;
  late PlutoGridController _plutoGridController = PlutoGridController();
  CustomProductPlutoTable({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.55,
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      child: CustomPlutoTable(
        controller: _plutoGridController,
        mode: PlutoGridMode.readOnly,
        noRowsWidget: MessageScreen(text: AppStrings.notFound.tr),
        columns: _buildColumns(context),
        rows: _buildRows().toList(),
        showDefaultHeader: false,
        onLoaded: (PlutoGridOnLoadedEvent event) {
          _plutoGridController =
              PlutoGridController(stateManager: event.stateManager);
          context.read<ProductBloc>().plutoGridController =
              _plutoGridController;
        },
      ),
    );
  }

  List<PlutoColumn> _buildColumns(BuildContext context) {
    return [
      PlutoColumn(
        title: 'code'.tr,
        field: 'code',
        enableFilterMenuItem: true,
        enableContextMenu: false,
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          ProductEntity productEntity = products
              .firstWhere((product) => product.id == rendererContext.row.data);
          return Row(
            children: [
              ProductOptionMenu(
                productEntity: productEntity,
              ),
              const SizedBox(width: 8),
              Text(rendererContext.cell.value),
            ],
          );
        },
      ),
      PlutoColumn(
        title: 'ar_name'.tr,
        field: 'ar_name',
        enableFilterMenuItem: true,
        enableContextMenu: false,
        width: MediaQuery.sizeOf(context).width * 0.4,
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
    ];
  }

  _buildRows() {
    return products.map(
      (product) {
        return PlutoRow(
          type: PlutoRowTypeGroup(children: FilteredList()),
          data: product.id,
          cells: {
            'code': PlutoCell(value: product.code),
            'ar_name': PlutoCell(value: product.arName),
            'en_name': PlutoCell(value: product.enName),
          },
        );
      },
    );
  }
}
