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
}
