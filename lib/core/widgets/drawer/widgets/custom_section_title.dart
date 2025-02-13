import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class CustomSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  const CustomSectionTitle(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: AppColors.secondaryColorLow),
      ),
      leading: Icon(
        icon,
        color: AppColors.secondaryColorLow,
      ),
      onTap: () {},
    );
  }
}
