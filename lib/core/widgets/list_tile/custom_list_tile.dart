import 'package:flutter/material.dart';
import 'package:ngu_app/app/config/app_ui.dart';
import 'package:ngu_app/app/config/constant.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Function onTap;
  final IconData? icon;
  final String subTitle;
  final bool isTrailing;
  final IconData trailingIcon;

  const CustomListTile({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.subTitle = ' ',
    this.isTrailing = true,
    this.trailingIcon = Icons.arrow_forward_ios,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppUI.white,
        // size: Dimensions.smallIconSize,
      ),
      title: Text(
        title,
        style: const TextStyle(color: AppUI.white),
      ),
      trailing: isTrailing
          ? Icon(
              trailingIcon,
              color: AppUI.white,
            )
          : null,
      subtitle: subTitle != ' '
          ? Text(
              subTitle,
              style: const TextStyle(

                  // fontSize: Dimensions.secondaryTextSize
                  ),
            )
          : null,
      splashColor: AppUI.white.withOpacity(0.3),
      onTap: () {
        onTap();
      },
    );
  }
}
