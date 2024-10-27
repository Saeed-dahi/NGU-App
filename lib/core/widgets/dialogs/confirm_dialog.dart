import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class ConfirmDialog {
  static showConfirmDialog(VoidCallback onCancel, VoidCallback onConfirm) {
    Get.defaultDialog(
      confirm: TextButton(
        onPressed: () {
          Get.back();
          onConfirm();
        },
        autofocus: true,
        child: Text('yes'.tr),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back();
        },
        autofocus: true,
        child: Text('no'.tr),
      ),
      middleText: 'are_you_sure'.tr,
      textConfirm: 'yes'.tr,
      textCancel: 'no'.tr,
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      buttonColor: AppColors.primaryColor,
    );
  }
}
