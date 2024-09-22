import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MessageScreen extends StatelessWidget {
  final String text;
  final String lottieUrl;
  final VoidCallback? onTap;

  const MessageScreen(
      {super.key,
      required this.text,
      this.lottieUrl = 'assets/animations/no_data.json',
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
