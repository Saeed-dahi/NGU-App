import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/app_config/constant.dart';
import 'package:ngu_app/core/widgets/drawer/app_drawer.dart';
import 'package:ngu_app/features/home/presentation/cubit/tab_cubit.dart';

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
        return Scaffold(
          key: scaffoldKey,
          drawer: const AppDrawer(),
          appBar: AppBar(
            title: Text('accounting_system'.tr),
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(!isTabsEmpty ? Dimensions.appBarSize : 0),
              child: isTabsEmpty
                  ? const SizedBox()
                  : TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabs: List.generate(
                        state.tabs.length,
                        (index) {
                          return Tab(
                            child: Row(
                              children: [
                                Text(state.tabs[index].title),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    context.read<TabCubit>().removeTab(index);
                                  },
                                  padding: EdgeInsets.zero,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
          body: isTabsEmpty
              ? Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        '${'accounting_system'.tr}  ',
                        colors: [
                          AppColors.primaryColor,
                          AppColors.transparent,
                        ],
                        textStyle:
                            const TextStyle(fontSize: Dimensions.largeTextSize),
                      ),
                    ],
                    repeatForever: false,
                  ),
                )
              : TabBarView(
                  controller: _tabController,
                  children: state.tabs
                      .map(
                        (tab) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TabContent(content: tab.content),
                        ),
                      )
                      .toList(),
                ),
        );
      },
    );
  }
}

// to prevent updating a live tabs
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
