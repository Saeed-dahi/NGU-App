import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/core/widgets/custom_icon_button.dart';
import 'package:ngu_app/core/widgets/dialogs/confirm_dialog.dart';

import 'package:ngu_app/core/widgets/drawer/app_drawer.dart';
import 'package:ngu_app/core/widgets/global_key_listener.dart';
import 'package:ngu_app/features/home/presentation/cubit/tab_cubit.dart';
import 'package:ngu_app/features/home/presentation/widgets/tab_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  _updateTabController(int length) {
    _tabController?.dispose();
    _tabController = TabController(length: length, vsync: this);
    if (length > 0) _tabController?.animateTo(length - 1);

    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.closeDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TabCubit, TabState>(
      listener: (context, state) {
        _updateTabController(state.tabs.length);
      },
      builder: (context, state) {
        final isTabsEmpty = state.tabs.isEmpty;
        return GlobalKeyListener(
          child: Scaffold(
            key: scaffoldKey,
            drawer: const AppDrawer(),
            appBar: AppBar(
              title: Text('accounting_system'.tr),
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(!isTabsEmpty ? Dimensions.appBarSize : 0),
                child: isTabsEmpty
                    ? const SizedBox()
                    : _buildTabBar(state, context),
              ),
            ),
            body: isTabsEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: true,
                          child: SizedBox(
                              width: 200,
                              child: AnalogClock(
                                dialBorderColor: AppColors.primaryColor,
                                markingColor: AppColors.primaryColor,
                                hourHandColor: AppColors.primaryColor,
                                hourNumberColor: AppColors.primaryColor,
                                minuteHandColor: AppColors.primaryColor,
                                secondHandColor: AppColors.primaryColor,
                                centerPointColor: AppColors.primaryColor,
                                child: Align(
                                  alignment: const FractionalOffset(0.5, 0.75),
                                  child: Text(
                                    'accounting_system'.tr,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColorLow),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  )
                : _buildTabBarView(state),
          ),
        );
      },
    );
  }

  TabBarView _buildTabBarView(TabState state) {
    return TabBarView(
      controller: _tabController,
      children: state.tabs
          .map(
            (tab) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: TabContent(
                  key: PageStorageKey(tab.title), content: tab.content),
            ),
          )
          .toList(),
    );
  }

  Row _buildTabBar(TabState state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: List.generate(
            state.tabs.length,
            (index) {
              return Tab(
                key: PageStorageKey(state.tabs[index].title),
                child: Row(
                  children: [
                    Text(state.tabs[index].title),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        ConfirmDialog.showConfirmDialog(() {}, () {
                          context.read<TabCubit>().removeTab(index);
                        });
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        CustomIconButton(
          icon: Icons.close,
          tooltip: 'close'.tr,
          color: AppColors.white,
          onPressed: () {
            ConfirmDialog.showConfirmDialog(() {}, () {
              context.read<TabCubit>().removeAll();
            });
          },
        ),
      ],
    );
  }
}
