import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngu_app/app/app_management/theme/app_colors.dart';

class CustomTheme {
  // light theme
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.primaryColor,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryColor,
        fontSize: 23, //20
      ),
      iconTheme: IconThemeData(color: AppColors.secondaryColor),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: AppColors.secondaryColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.secondaryColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );

  // dark theme
  static final darkTheme = ThemeData(
    primaryColor: AppColors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.black,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.white,
        fontSize: 23, //20
      ),
      iconTheme: IconThemeData(color: AppColors.white),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: AppColors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
  );
}
