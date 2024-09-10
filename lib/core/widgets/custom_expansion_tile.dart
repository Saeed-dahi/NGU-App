import 'package:flutter/material.dart';

import 'package:ngu_app/app/config/app_ui.dart';
import 'package:ngu_app/app/config/constant.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  const CustomExpansionTile(
      {super.key,
      required this.title,
      required this.children,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: const Color.fromARGB(163, 255, 255, 255),
      collapsedIconColor: AppUI.white,
      collapsedTextColor: AppUI.white,
      leading: Icon(
        icon,
        size: Dimensions.iconSize,
      ),
      title: Text(title),
      children: children,
    );
  }
}
