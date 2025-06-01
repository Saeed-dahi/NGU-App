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

  static double getDiscountMultiplier(dynamic value) {
    double discount = double.tryParse(value.toString()) ?? 0;
    return (100 - discount) / 100;
  }

  static double calculateTax(dynamic taxRate, dynamic baseAmount) {
    double base = double.tryParse(baseAmount.toString()) ?? 0;
    return base * ((double.parse(taxRate) / 100) + 1);
  }

  static String normalizeArabic(String query) {
    // Normalize Arabic letters
    query = query
        .replaceAll(RegExp(r'[أإآٱ]'), 'ا')
        .replaceAll(RegExp(r'[يى]'), 'ي')
        .replaceAll(RegExp(r'[ة]'), 'ه')
        .replaceAll(RegExp(r'ء'), '');

    // Normalize Arabic numerals to English numerals
    query = query.replaceAllMapped(RegExp(r'[٠١٢٣٤٥٦٧٨٩]'), (match) {
      const arabicToEnglishNumbers = {
        '٠': '0',
        '١': '1',
        '٢': '2',
        '٣': '3',
        '٤': '4',
        '٥': '5',
        '٦': '6',
        '٧': '7',
        '٨': '8',
        '٩': '9',
      };
      return arabicToEnglishNumbers[match.group(0)!]!;
    });

    // Normalize English numerals to Arabic numerals
    query = query.replaceAllMapped(RegExp(r'[0-9]'), (match) {
      const englishToArabicNumbers = {
        '0': '٠',
        '1': '١',
        '2': '٢',
        '3': '٣',
        '4': '٤',
        '5': '٥',
        '6': '٦',
        '7': '٧',
        '8': '٨',
        '9': '٩',
      };
      return englishToArabicNumbers[match.group(0)!]!;
    });

    // Handle keyboard layout mismatches
    query = query.replaceAllMapped(RegExp(r'[a-zA-Z]'), (match) {
      const keyboardMappingToArabic = {
        'q': 'ض',
        'w': 'ص',
        'e': 'ث',
        'r': 'ق',
        't': 'ف',
        'y': 'غ',
        'u': 'ع',
        'i': 'ه',
        'o': 'خ',
        'p': 'ح',
        'a': 'ش',
        's': 'س',
        'd': 'ي',
        'f': 'ب',
        'g': 'ل',
        'h': 'ا',
        'j': 'ت',
        'k': 'ن',
        'l': 'م',
        'z': 'ئ',
        'x': 'ء',
        'c': 'ؤ',
        'v': 'ر',
        'b': 'لا',
        'n': 'ى',
        'm': 'ة'
      };

      return keyboardMappingToArabic[match.group(0)!] ?? match.group(0)!;
    });

    // Handle Arabic-to-English keyboard layout mismatches
    query = query.replaceAllMapped(RegExp(r'[ضصثقفغعهخحشسيبلاتنمكطذدزروئءؤر]'),
        (match) {
      const keyboardMappingToEnglish = {
        'ض': 'q',
        'ص': 'w',
        'ث': 'e',
        'ق': 'r',
        'ف': 't',
        'غ': 'y',
        'ع': 'u',
        'ه': 'i',
        'خ': 'o',
        'ح': 'p',
        'ش': 'a',
        'س': 's',
        'ي': 'd',
        'ب': 'f',
        'ل': 'g',
        'ا': 'h',
        'ت': 'j',
        'ن': 'k',
        'م': 'l',
        'ئ': 'z',
        'ء': 'x',
        'ؤ': 'c',
        'ر': 'v',
        'لا': 'b',
        'ى': 'n',
        'ة': 'm',
        'و': 'z',
        'ز': 'w',
        'د': 'e',
        'ط': 'r',
        'ك': 't',
        'ذ': 'y'
      };

      return keyboardMappingToEnglish[match.group(0)!] ?? match.group(0)!;
    });

    return query;
  }
}
