import 'dart:ui';

import 'package:get/get.dart';
import 'package:tailor_book/Services/en_US.dart';
import 'package:tailor_book/Services/ur_PK.dart';


class LocalizationService extends Translations {
  // Default locale
  static final locale = Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('ur', 'PK');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'English',
    'اردو',
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('ur', 'PK'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS, // lang/en_us.dart
    'ur_PK': urPK, // lang/ur_pk.dart
  };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}