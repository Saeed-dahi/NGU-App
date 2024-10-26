import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class ConfirmDialog {
  static showConfirmDialog(VoidCallback onCancel, VoidCallback onConfirm) {
    Get.defaultDialog(
      middleText: 'are_you_sure'.tr,
      textConfirm: 'yes'.tr,
      textCancel: 'no'.tr,
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      buttonColor: AppColors.primaryColor,
      onConfirm: () {
        Get.back();
        onConfirm();
      },
      onCancel: onCancel,
    );
  }
}
