import 'package:Cek_Tugas_Akhir/services/translation_services.dart';
import 'package:Cek_Tugas_Akhir/utils/constant_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  final RxString bgImagePath = ''.obs;
  final RxString selectedLanguage = 'English'.obs;
  final RxString selectedTheme = ''.obs;

  @override
  void onInit() {
    final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    setBgImg(brightness == Brightness.dark);
    super.onInit();
  }

  void setBgImg(bool isDarkMode) {
    bgImagePath.value = isDarkMode
        ? ConstantAssets.imgBgDark
        : ConstantAssets.imgBgLight;
  }

  void changeLanguage(String lang){
    selectedLanguage.value = lang;
    TranslationService.changeLocale(lang);
  }

  void changeTheme(String theme){
    selectedTheme.value = theme;
    if (theme == 'System'){
      Get.changeThemeMode(ThemeMode.system);
    } else if (theme == 'Light'){
      Get.changeThemeMode(ThemeMode.light);
    } else if (theme == 'Dark'){
      Get.changeThemeMode(ThemeMode.dark);
    }
  }
}
