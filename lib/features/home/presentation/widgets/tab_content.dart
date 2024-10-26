// to prevent updating a live tabs
import 'package:flutter/material.dart';

class TabContent extends StatefulWidget {
  final Widget content;
  const TabContent({super.key, required this.content});

  @override
  State<TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<TabContent>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.content;
  }

  @override
  bool get wantKeepAlive => true;
}
