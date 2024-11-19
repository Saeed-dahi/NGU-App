import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/sections/accounts_section.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/sections/data_section.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/sections/settings_section.dart';
import 'package:ngu_app/core/widgets/drawer/widgets/sections/stock_control_section.dart';
import 'package:ngu_app/features/home/presentation/cubits/home_cubit/home_cubit.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.primaryPadding),
      child: Drawer(
        backgroundColor: AppColors.primaryColorLow,
        width: MediaQuery.sizeOf(context).width * 0.22,
        shadowColor: AppColors.primaryColorLow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: BlocBuilder<HomeCubit, ChangeSideBarState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Lottie.asset('assets/animations/splash_animation.json',
                    reverse: true,
                    height: MediaQuery.of(context).size.height * 0.2),
                const Divider(
                  thickness: Dimensions.smallDividerThickness,
                ),
                DataSection(
                  initiallyExpanded: state.pressedButton == 'data',
                ),
                const Divider(
                  endIndent: 10,
                  indent: 10,
                ),
                AccountsSection(
                  initiallyExpanded: state.pressedButton == 'accounting',
                ),
                const Divider(
                  endIndent: 10,
                  indent: 10,
                ),
                StockControlSection(
                  initiallyExpanded: state.pressedButton == 'stock_control',
                ),
                const Divider(
                  endIndent: 10,
                  indent: 10,
                ),
                SettingsSection(
                  initiallyExpanded: state.pressedButton == 'settings',
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
