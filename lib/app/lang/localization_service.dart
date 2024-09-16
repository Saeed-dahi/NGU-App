import 'package:get/get.dart';
import 'package:ngu_app/app/lang/ar.dart';
import 'package:ngu_app/app/lang/en.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': ar,
        'en': en,
      };

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> cacheLanguageCode(String code) async {
    final SharedPreferences sharedPreferences = await _prefs;
    sharedPreferences.setString('lang_code', code);
  }

  Future<String> getCachedLanguage() async {
    final sharedPreferences = await _prefs;
    final cachedLanguage = sharedPreferences.getString('lang_code');
    if (cachedLanguage != null) {
      return cachedLanguage;
    }
    return 'ar';
  }
}
