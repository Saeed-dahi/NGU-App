import 'package:flutter/material.dart';

class CustomSavedTab extends StatefulWidget {
  final Widget child;
  const CustomSavedTab({super.key, required this.child});

  @override
  State<CustomSavedTab> createState() => _CustomSavedTabState();
}

class _CustomSavedTabState extends State<CustomSavedTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
