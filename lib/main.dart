import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ngu_app/app/app_config/api_list.dart';
import 'package:ngu_app/app/app_management/theme/app_theme.dart';
import 'package:ngu_app/app/lang/cubit/language_cubit.dart';
import 'package:ngu_app/app/lang/localization_service.dart';
import 'package:ngu_app/core/widgets/tables/pluto_grid/cubit/pluto_grid_cubit.dart';
import 'package:ngu_app/features/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:ngu_app/features/home/presentation/cubits/tab_cubit/tab_cubit.dart';
import 'package:window_manager/window_manager.dart';
import 'app/dependency_injection/dependency_injection.dart' as di;
import 'package:ngu_app/features/splash/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // dependency injection
  await di.init();

  // Initialize window manager
  await windowManager.ensureInitialized();
  // Set minimum window size
  windowManager.setMinimumSize(const Size(1000, 800)); // Example minimum size

  await APIList.loadBaseUrl();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit()..getSavedLanguage(),
        ),
        BlocProvider(
          create: (context) => TabCubit(),
        ),
        BlocProvider(
          create: (_) => HomeCubit()..hideBigSideBar(),
        ),
        BlocProvider(
          create: (_) => PlutoGridCubit(),
          lazy: true,
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          if (state is ChangeLanguageState) {
            return GetMaterialApp(
              title: 'accounting_system'.tr,
              debugShowCheckedModeBanner: false,
              locale: state.locale,
              fallbackLocale: state.locale,
              translations: LocalizationService(),
              theme: CustomTheme.lightTheme,
              home: const SplashScreen(),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
