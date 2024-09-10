import 'package:flutter/material.dart';
import 'package:ngu_app/app/config/app_ui.dart';

class BasicListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function? function;
  const BasicListTile(
      {super.key, required this.title, required this.icon, this.function});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: AppUI.secondaryColor,
      title: Text(
        title,
      ),
      leading: Icon(
        icon,
      ),
      onTap: () {
        function ?? () {};
      },
    );
  }
}
