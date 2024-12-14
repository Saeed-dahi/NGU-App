import 'package:intl/intl.dart';

class FormatterClass {
  static String numberFormatter(dynamic value) {
    return NumberFormat('#,###.#####').format(double.parse(value));
  }

  static double? doubleFormatter(dynamic value) {
    // return double.parse(value.replaceAll(",", ""));

    return value.runtimeType == double
        ? value
        : double.tryParse(value.replaceAll(",", ""));
  }

  static String normalizeArabic(String query) {
    return query
        .replaceAll(RegExp(r'[أإآ]'), 'ا')
        .replaceAll(RegExp(r'[يى]'), 'ي')
        .replaceAll(RegExp(r'[ةه]'), 'ه')
        .replaceAll(RegExp(r'ء'), '');
  }
}
