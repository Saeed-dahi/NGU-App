import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class BasicListTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final IconData icon;
  final VoidCallback? onTap;
  final Color hoverColor;
  const BasicListTile(
      {super.key,
      required this.title,
      this.trailing = const SizedBox(),
      required this.icon,
      this.onTap,
      this.hoverColor = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        hoverColor: hoverColor,
        title: Text(
          title,
        ),
        leading: Icon(
          icon,
        ),
        onTap: onTap,
        trailing: trailing);
  }
}
