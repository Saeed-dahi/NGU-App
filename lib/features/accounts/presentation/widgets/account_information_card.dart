import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/config/constant.dart';

class AccountInformationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const AccountInformationCard(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(Dimensions.primaryPadding),
      color: AppColors.secondaryColorLow,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: Dimensions.secondaryTextSize),
            )
          ],
        ),
      ),
    );
  }
}
