import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:frontend/app/data/controller/student_controller.dart';
import 'package:frontend/app/data/controller/user_controller.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/services/translation_services.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:frontend/core/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final StudentController _studentController = Get.find<StudentController>();

  final RxString bgImagePath = ''.obs;
  final RxString selectedLanguage = 'English'.obs;
  final RxString selectedTheme = 'System'.obs; // ✅ Default agar tidak kosong

  @override
  void onInit() {
    final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    setBgImg(brightness == Brightness.dark);

    final storedLang = GetStorage().read('language');
    if (storedLang != null) {
      selectedLanguage.value = storedLang;
    }

    final storedTheme = GetStorage().read('theme');
    if (storedTheme != null) {
      selectedTheme.value = storedTheme;
    }

    if (_studentController.student.value == null) {
      _studentController.getMyData();
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (selectedLanguage.isNotEmpty) {
      TranslationService.changeLocale(selectedLanguage.value);
    }

    if (selectedTheme.isNotEmpty) {
      changeTheme(selectedTheme.value);
    }
  }

  void setBgImg(bool isDarkMode) {
    bgImagePath.value = isDarkMode
        ? ConstantAssets.imgBgDark
        : ConstantAssets.imgBgLight;
  }

  void changeLanguage(String lang){
    selectedLanguage.value = lang;
    TranslationService.changeLocale(lang);
    GetStorage().write('language', lang);
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
    GetStorage().write('theme', theme);
  }

  String get fullName => _studentController.student.value?.fullName ?? 'Student';
  String? get majors => _studentController.student.value?.majors;
  String? get studyProgram => _studentController.student.value?.studyProgram;
  int? get nim => _studentController.student.value?.nim;

  void logout() {
    LocalStorageService.clearAll();
    Get.find<UserController>().user.value = null;
    Get.find<StudentController>().student.value = null;
    Get.offAllNamed(Routes.LOGIN);
  }
}
