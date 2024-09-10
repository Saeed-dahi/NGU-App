import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ngu_app/app/config/app_ui.dart';
import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/sections/accounts_section.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/sections/data_section.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/sections/settings_section.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/sections/stock_control_section.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Drawer build(BuildContext context) {
    return Drawer(
      backgroundColor: AppUI.secondaryColorLow,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Lottie.asset('assets/animations/splash_animation.json',
              reverse: true, height: MediaQuery.of(context).size.width * 0.1),
          const Divider(
            thickness: Dimensions.smallDividerThickness,
          ),
          const DataSection(),
          const Divider(
            endIndent: 10,
            indent: 10,
          ),
          const AccountsSection(),
          const Divider(
            endIndent: 10,
            indent: 10,
          ),
          const StockControlSection(),
          const Divider(
            endIndent: 10,
            indent: 10,
          ),
          SettingsSection()
        ],
      ),
    );
  }
}
