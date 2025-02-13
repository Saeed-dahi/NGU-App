import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:ngu_app/app/lang/localization_service.dart';
import 'package:ngu_app/features/splash/presentation/screens/splash_screen.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<ChangeLanguageState> {
  LanguageCubit() : super(ChangeLanguageState(locale: const Locale('ar')));

  Future<void> getSavedLanguage() async {
    final String code = await LocalizationService().getCachedLanguage();
    emit(ChangeLanguageState(locale: Locale(code)));
  }

  Future<void> changeLanguage(String code) async {
    await LocalizationService().cacheLanguageCode(code);
    Get.updateLocale(Locale(code));
    Get.offAll(() => const SplashScreen());
  }
}
