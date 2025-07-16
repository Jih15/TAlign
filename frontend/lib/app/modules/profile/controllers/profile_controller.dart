import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:frontend/app/data/controller/user_controller.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/services/translation_services.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:frontend/utils/services/token.dart';
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

  void logout() {
    box.remove('access_token');
    Get.find<UserController>().user.value = null;
    Get.offAllNamed(Routes.LOGIN);
  }
}
