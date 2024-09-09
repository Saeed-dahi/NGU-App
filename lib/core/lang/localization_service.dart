import 'package:get/get.dart';
import 'package:ngu_app/core/lang/ar.dart';
import 'package:ngu_app/core/lang/en.dart';

class LocalizationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': ar,
        'en': en,
      };
}
