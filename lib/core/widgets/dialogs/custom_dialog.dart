import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/config/constant.dart';

class ShowDialog {
  static showCustomDialog(
      {required BuildContext context,
      required content,
      double width = 0.5,
      double height = 0.6}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Builder(
        builder: (controller) {
          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width * width,
              height: MediaQuery.of(context).size.height * height,
              child: Center(
                child: content,
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Dimensions.primaryRadius,
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColorLow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Dimensions.primaryRadius,
                    ),
                  ),
                ),
                child: Text(
                  "close".tr,
                  style: const TextStyle(
                    color: AppColors.lightBgGrayColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
