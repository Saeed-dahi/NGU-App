import 'package:flutter/material.dart';

import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  bool skipTraversal;
  Color color;
  CustomIconButton(
      {super.key,
      required this.icon,
      required this.tooltip,
      this.onPressed,
      this.skipTraversal = true,
      this.color = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: IconButton(
        icon: Icon(
          icon,
          // size: Dimensions.largeIconSize,
        ),
        onPressed: onPressed,
        tooltip: tooltip,
        color: color,
        focusNode: FocusNode(skipTraversal: skipTraversal),
      ),
    );
  }
}
