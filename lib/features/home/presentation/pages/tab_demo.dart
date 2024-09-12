import 'package:flutter/material.dart';

class TabDemo extends StatefulWidget {
  const TabDemo({super.key});

  @override
  TabDemoState createState() => TabDemoState();
}

class TabDemoState extends State<TabDemo> with TickerProviderStateMixin {
  List<TabData> tabs = [];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _addNewTab(); // Add the first tab by default
  }

  void _addNewTab() {
    setState(() {
      tabs.add(TabData(
        title: 'Tab ${tabs.length + 1}',
        content: Center(child: Text('Content for Tab ${tabs.length + 1}')),
      ));
      _tabController = TabController(length: tabs.length, vsync: this);
    });
  }

  void _removeTab(int index) {
    setState(() {
      tabs.removeAt(index);
      _tabController = TabController(length: tabs.length, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewTab,
          ),
        ],
        bottom: tabs.isEmpty
            ? null
            : TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: List.generate(tabs.length, (index) {
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
                }),
              ),
      ),
      body: tabs.isEmpty
          ? const Center(child: Text('No tabs open'))
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
