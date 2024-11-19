import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/features/home/presentation/cubits/home_cubit/home_cubit.dart';

class AppIconDrawer extends StatefulWidget {
  const AppIconDrawer({super.key});

  @override
  State<AppIconDrawer> createState() => _AppIconDrawerState();
}

class _AppIconDrawerState extends State<AppIconDrawer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<HomeCubit>().hideBigSideBar(),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.primaryPadding),
        child: Drawer(
          backgroundColor: AppColors.primaryColorLow,
          elevation: 10,
          width: 50,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomIconButton(
                icon: Icons.folder,
                tooltip: 'data'.tr,
                color: AppColors.white,
                onPressed: () {
                  context.read<HomeCubit>().showBigSideBar('data');
                },
              ),
              CustomIconButton(
                icon: Icons.account_balance_outlined,
                tooltip: 'accounting'.tr,
                color: AppColors.white,
                onPressed: () {
                  context.read<HomeCubit>().showBigSideBar('accounting');
                },
              ),
              CustomIconButton(
                icon: Icons.inventory_2_outlined,
                tooltip: 'stock_control'.tr,
                color: AppColors.white,
                onPressed: () {
                  context.read<HomeCubit>().showBigSideBar('stock_control');
                },
              ),
              CustomIconButton(
                icon: Icons.settings_outlined,
                tooltip: 'settings'.tr,
                color: AppColors.white,
                onPressed: () {
                  context.read<HomeCubit>().showBigSideBar('settings');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
