import 'package:flutter/material.dart';

import 'package:ngu_app/app/config/constant.dart';
import 'package:ngu_app/core/widgets/app_bar.dart';
import 'package:ngu_app/core/widgets/drawer/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: AppDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensions.appBarSize),
        child: TopAppBar(
          'Home page',
        ),
      ),
      body: Center(
        child: Text(
          'Home Screen',
          style: TextStyle(fontSize: 100),
        ),
      ),
    );
  }
}
