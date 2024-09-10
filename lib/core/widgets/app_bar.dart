import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/config/app_ui.dart';
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
            backgroundColor: AppUI.secondaryColor,
            automaticallyImplyLeading: hasBackButton,
            iconTheme: const IconThemeData(color: AppUI.white),
            shadowColor: AppUI.white,
            elevation: 0,
            title: Text(
              '${'ngu'.tr} ${'accounting_system'.tr}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppUI.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
