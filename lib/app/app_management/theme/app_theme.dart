import 'package:flutter/material.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';
import 'package:ngu_app/app/config/constant.dart';

class CustomTheme {
  // light theme
  static final lightTheme = ThemeData(
    fontFamily: 'tajawal',
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColorLow,
        iconTheme: IconThemeData(color: AppColors.white),
        shadowColor: AppColors.primaryColor,
        elevation: 8,
        titleTextStyle: TextStyle(
            color: AppColors.white,
            fontFamily: 'tajawal',
            fontSize: Dimensions.primaryTextSize)),
    tabBarTheme: const TabBarTheme(
      labelColor: AppColors.white,
      indicatorColor: AppColors.white,
    ),
    useMaterial3: true,
    // ignore: prefer_const_constructors
    iconButtonTheme: IconButtonThemeData(
      style: const ButtonStyle(
        shape: WidgetStatePropertyAll(
          CircleBorder(
            // side: BorderSide(color: AppColors.primaryColorLow, width: 2),
          ),
        ),
      ),
    ),
  );

  // dark theme
  static final darkTheme = ThemeData(
    fontFamily: 'tajawal',
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.white),
    useMaterial3: true,
  );
}
