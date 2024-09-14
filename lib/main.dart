import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_management/theme/app_theme.dart';
import 'package:ngu_app/app/lang/localization_service.dart';
import 'package:ngu_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize window manager
  await windowManager.ensureInitialized();

  // Set minimum window size
  windowManager.setMinimumSize(const Size(1000, 800)); // Example minimum size

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      translations: LocalizationService(),
      theme: CustomTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
