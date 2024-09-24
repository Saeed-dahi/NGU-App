import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/config/constant.dart';

class ShowSnackBar {
  static showValidationSnackbar({
    required List<String> messages,
  }) {
    String errorMessage = messages.join('\n');
    return Get.rawSnackbar(
      messageText: Text(
        errorMessage,
        style: const TextStyle(
            color: AppColors.white, fontSize: Dimensions.secondaryTextSize),
      ),
      icon: const Icon(Icons.info),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 1),
      backgroundColor: AppColors.red.withOpacity(0.8),
      borderRadius: 15.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(20.0),
      shouldIconPulse: true,
      onTap: (_) {},
    );
  }

  static showSuccessSnackbar({required String message}) {
    return Get.rawSnackbar(
      messageText: Text(
        message,
        style: const TextStyle(
            color: AppColors.black, fontSize: Dimensions.secondaryTextSize),
      ),
      icon: const Icon(Icons.check_circle),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.green.withOpacity(0.8),
      borderRadius: 15.0,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(20.0),
      shouldIconPulse: true,
      onTap: (_) {},
    );
  }
}
