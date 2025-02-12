import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';

class MessageScreen extends StatelessWidget {
  final String text;
  final String lottieUrl;
  final VoidCallback? onTap;
  void Function()? onAdd;
  void Function()? onRefresh;

  MessageScreen(
      {super.key,
      required this.text,
      this.lottieUrl = 'assets/animations/no_data.json',
      this.onTap,
      this.onAdd,
      this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: onAdd != null,
                child: CustomIconButton(
                  icon: Icons.add,
                  tooltip: 'add'.tr,
                  onPressed: onAdd,
                ),
              ),
              Visibility(
                visible: onRefresh != null,
                child: CustomIconButton(
                  icon: Icons.refresh,
                  tooltip: 'refresh'.tr,
                  onPressed: onRefresh,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: Lottie.asset(lottieUrl),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
