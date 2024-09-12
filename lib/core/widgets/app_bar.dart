import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/config/constant.dart';

class TopAppBar extends StatelessWidget {
  final String title;
  final Widget? matchAll;
  final bool hasBackButton;
  final bool hasLogo;
  final bool hasActions;

  const TopAppBar(this.title,
      {super.key,
      this.matchAll,
      this.hasBackButton = true,
      this.hasLogo = false,
      this.hasActions = false});
  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(Dimensions.appBarSize),
      child: Wrap(
        children: [
          AppBar(
            // forceMaterialTransparency: true,
            backgroundColor: AppColors.secondaryColor,
            automaticallyImplyLeading: hasBackButton,
            iconTheme: const IconThemeData(color: AppColors.white),
            shadowColor: AppColors.white,
            elevation: 0,
            title: Text(
              ' ${'accounting_system'.tr}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
