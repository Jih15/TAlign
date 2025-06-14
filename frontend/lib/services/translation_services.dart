import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TranslationService extends Translations {
  static final locale = Locale('en', 'US');
  static final fallbackLocale = Locale('en', 'US');

  static final langs = ['English', 'Bahasa Indonesia'];

  static final locales = [
    Locale('en', 'US'),
    Locale('id', 'ID'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'language': 'Language',
      'appearance': 'Appearance',
      'english': 'English',
      'indonesian': 'Bahasa Indonesia',
      'system': 'System',
      'light': 'Light',
      'dark': 'Dark',
    },
    'id_ID': {
      'language': 'Bahasa',
      'appearance': 'Tampilan',
      'english': 'Inggris',
      'indonesian': 'Bahasa Indonesia',
      'system': 'Sistem',
      'light': 'Terang',
      'dark': 'Gelap',
    },
  };

  static void changeLocale(String lang) {
    final index = langs.indexOf(lang);
    if (index != -1) {
      final locale = locales[index];
      Get.updateLocale(locale);
    } else {
      Get.updateLocale(fallbackLocale);
    }
  }

  static String get currentLanguageCode => Get.locale?.languageCode ?? 'en';
}
