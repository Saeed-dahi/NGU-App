import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_config/constant.dart';

class ShowDialog {
  static showCustomDialog(
      {required BuildContext context,
      required content,
      double width = 0.5,
      double height = 0.7,
      bool saveButton = false,
      VoidCallback? onSave}) {
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
          );
        },
      ),
    );
  }
}
