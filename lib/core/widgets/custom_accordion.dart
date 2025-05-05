import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class CustomAccordion extends StatelessWidget {
  final bool isOpen;
  final String title;
  final IconData icon;
  final Widget contentWidget;

  const CustomAccordion(
      {super.key,
      required this.isOpen,
      required this.title,
      required this.icon,
      required this.contentWidget});

  @override
  Widget build(BuildContext context) {
    return Accordion(
      rightIcon: const Icon(Icons.expand_more),
      disableScrolling: true,
      children: [
        AccordionSection(
          isOpen: isOpen,
          leftIcon: Icon(icon, color: AppColors.white),
          rightIcon: const Icon(Icons.keyboard_arrow_down_outlined,
              color: AppColors.white),
          header: Text(
            title,
            style: const TextStyle(
                fontSize: Dimensions.primaryTextSize, color: AppColors.white),
          ),
          content: contentWidget,
          headerPadding: const EdgeInsets.all(Dimensions.primaryPadding),
          headerBackgroundColor: AppColors.primaryColorLow,
          headerBackgroundColorOpened: AppColors.green,
        ),
      ],
    );
  }
}
