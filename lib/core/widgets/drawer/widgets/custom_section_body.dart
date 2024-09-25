import 'package:flutter/widgets.dart';
import 'package:ngu_app/app/app_config/constant.dart';

class CustomSectionBody extends StatelessWidget {
  final List<Widget> children;
  const CustomSectionBody({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.primaryPadding, right: Dimensions.primaryPadding),
      child: Column(children: children),
    );
  }
}
