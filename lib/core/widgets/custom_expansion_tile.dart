import 'package:flutter/material.dart';

import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/app_config/constant.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  final Color backgroundColor;
  final Color collapsedIconColor;
  final Color collapsedTextColor;
  final Color activeColor;
  final bool initiallyExpanded;
  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
    required this.icon,
    this.initiallyExpanded = false,
    this.backgroundColor = const Color.fromARGB(163, 255, 255, 255),
    this.collapsedIconColor = AppColors.white,
    this.collapsedTextColor = AppColors.white,
    this.activeColor = AppColors.primaryColorLow,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: backgroundColor,
      collapsedIconColor: collapsedIconColor,
      collapsedTextColor: collapsedTextColor,
      iconColor: activeColor,
      textColor: activeColor,
      initiallyExpanded: initiallyExpanded,
      childrenPadding: const EdgeInsets.only(
          left: Dimensions.primaryPadding,
          right: Dimensions.primaryPadding + 10),
      leading: Icon(
        icon,
        size: Dimensions.iconSize,
      ),
      title: Text(title),
      children: children,
    );
  }
}
