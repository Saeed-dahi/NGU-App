import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/core/widgets/app_bar.dart';
import 'package:ngu_app/core/widgets/drawer/app_drawer.dart';
import 'package:ngu_app/features/home/presentation/pages/tab_demo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(Dimensions.appBarSize),
        child: TopAppBar(
          'Home page',
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Get.to(const TabDemo());
          },
          child: const Text(
            'Home Screen',
            style: TextStyle(fontSize: 100),
          ),
        ),
      ),
    );
  }
}
