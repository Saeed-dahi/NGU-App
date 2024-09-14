import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ngu_app/core/widgets/drawer/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<TabData> tabs = [];

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _addNewTab();
  }

  _addNewTab() {
    setState(() {
      tabs.add(
          TabData(title: 'title', content: const Center(child: Text('data'))));
      _tabController = TabController(length: tabs.length, vsync: this);
    });
  }

  _removeTab(int index) {
    setState(() {
      tabs.removeAt(index);
      _tabController = TabController(length: tabs.length, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(' ${'accounting_system'.tr}'),
        actions: [
          IconButton(
              onPressed: () {
                _addNewTab();
              },
              icon: const Icon(Icons.add))
        ],
        bottom: tabs.isEmpty
            ? null
            : TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: List.generate(
                  tabs.length,
                  (index) {
                    return Tab(
                      child: Row(
                        children: [
                          Text(tabs[index].title),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => _removeTab(index),
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
      body: tabs.isEmpty
          ? const Center(
              child: Text('Hi'),
            )
          : TabBarView(
              controller: _tabController,
              children: tabs.map((tab) => tab.content).toList(),
            ),
    );
  }
}

class TabData {
  final String title;
  final Widget content;

  TabData({required this.title, required this.content});
}
