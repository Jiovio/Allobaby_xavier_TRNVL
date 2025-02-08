import 'dart:ui';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import '../main.dart';
import 'en.dart';
import 'hi.dart';
import 'ta.dart';
import 'ch.dart';
import 'ka.dart';
import 'ma.dart';
import 'ml.dart';
import 'tl.dart';





class TranslationService extends Translations {
  // Default locale
  static final locale = Locale("en");
  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('en');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'English',
    'Hindi(हिन्दी)',
    'Tamil(தமிழ்)',
    'Kannada(ಕನ್ನಡ)',
    'Marathi (मराठी)',
    "Chinese",
    "Malayalam",
    "Telugu"
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('en'),
    const Locale('hi'),
    const Locale('ta'),
    const Locale('ka'),
    const Locale('ma'),
    const Locale('ch'),
    const Locale('ml'),
    const Locale('tl'),

  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'hi': hi,
        'ta': ta,
        'ch': ch,
        'ka':ka,
        'ma':ma,
        'ml': ml,
        'tl': tl
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    // print(lang);
    final locale = getLocaleFromLanguage(lang);
    // print("---------------------------------|");

    // print(locale!.toLanguageTag());

    // print("---------------------------------|");

    localStorage.setItem("lang", locale!.toLanguageTag());
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }

  // ignore: missing_return
  getLanguageFromLocal(String local) {
    for (int i = 0; i < locales.length; i++) {
      if (Locale(local) == locales[i]) return langs[i];
    }
  }
}
