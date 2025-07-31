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
      LangKeys.language: 'Language',
      LangKeys.appearance: 'Appearance',
      LangKeys.english: 'English',
      LangKeys.indonesian: 'Bahasa Indonesia',
      LangKeys.system: 'System',
      LangKeys.light: 'Light',
      LangKeys.dark: 'Dark',
      LangKeys.selectTheme: 'Select Theme',

      // Feature Card
      LangKeys.generateProjectIdeas: 'Generate Project Ideas',
      LangKeys.titleGenerate: 'Let\'s try it now!',
      LangKeys.similarityCheck: 'Similarity Check',
      LangKeys.submitProjectIdeas: 'Submit Project Ideas',

      // Home
      LangKeys.homeGreeting: 'Hello, @name!',
      LangKeys.homeSubtitle: 'Help your project ideas with us :)',
    },

    'id_ID': {
      LangKeys.language: 'Bahasa',
      LangKeys.appearance: 'Tampilan',
      LangKeys.english: 'Inggris',
      LangKeys.indonesian: 'Bahasa Indonesia',
      LangKeys.system: 'Sistem',
      LangKeys.light: 'Terang',
      LangKeys.dark: 'Gelap',
      LangKeys.selectTheme: 'Pilih Tema',

      // Feature Card
      LangKeys.generateProjectIdeas: 'Generate Ide Project',
      LangKeys.titleGenerate: 'Coba sekarang!',
      LangKeys.similarityCheck: 'Pengecekan Kesamaan',
      LangKeys.submitProjectIdeas: 'Ajukan Ide Project',

      // Home
      LangKeys.homeGreeting: 'Halo, @name!',
      LangKeys.homeSubtitle: 'Bantu wujudkan ide proyek kamu bersama kami :)',
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


class LangKeys {
  // Home
  static const homeGreeting = 'home.greeting';
  static const homeSubtitle = 'home.subtitle';

  // Feature Card
  static const generateProjectIdeas = 'feature_card.generate_project_ideas';
  static const titleGenerate = 'feature_card.title_generate';
  static const similarityCheck = 'feature_card.similarity_check';
  static const submitProjectIdeas = 'feature_card.submit_project_ideas';

  // Common
  static const language = 'language';
  static const appearance = 'appearance';
  static const english = 'english';
  static const indonesian = 'indonesian';
  static const system = 'system';
  static const light = 'light';
  static const dark = 'dark';

  // Theme
  static const selectTheme = 'select_theme';

  // Logout, login, etc (tambahkan sesuai kebutuhan)
  static const logout = 'logout';
}
