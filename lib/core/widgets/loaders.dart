import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class Loaders {
  static Widget loading({
    double strokeAlign = 8,
    double strokeWidth = 8,
  }) {
    return Container(
      color: AppColors.lightBgGrayColor.withOpacity(0.5),
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
        strokeAlign: strokeAlign,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
