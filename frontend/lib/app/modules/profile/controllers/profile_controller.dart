import 'package:flutter/material.dart';
import 'package:frontend/app/data/controller/student_controller.dart';
import 'package:frontend/app/data/controller/user_controller.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/services/translation_services.dart';
import 'package:frontend/core/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final StudentController _studentController = Get.find<StudentController>();
  final UserController _userController = Get.find<UserController>();

  final RxString selectedLanguage = 'English'.obs;
  final RxString selectedTheme = 'System'.obs;

  // Student text controller
  final nimController = TextEditingController();
  final fullNameController = TextEditingController();
  final majorsController = TextEditingController();
  final selectedStudy = RxnString();

  // User text controller
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;

  var isStudentTab = true.obs;
  var isLoading = false.obs;

  // Data Student
  String get fullName => _studentController.student.value?.fullName ?? 'Student';
  String? get majors => _studentController.student.value?.majors ?? 'Majors not fill yet';
  String? get studyProgram => _studentController.student.value?.studyProgram ?? 'Study Program not fill yet';
  int? get nim => _studentController.student.value?.nim ?? 0;

  // Data User
  String get username => _userController.user.value?.username ?? 'Username';
  String get email => _userController.user.value?.email ?? 'Email';

  @override
  void onInit() {
    final storedLang = GetStorage().read('language');
    if (storedLang != null) selectedLanguage.value = storedLang;

    final storedTheme = GetStorage().read('theme');
    if (storedTheme != null) selectedTheme.value = storedTheme;

    final user = _userController.user.value;
    if (user != null) {
      usernameController.text = user.username ?? '';
      emailController.text = user.email ?? '';
    }

    final student = _studentController.student.value;
    if (student != null) {
      nimController.text = student.nim.toString();
      fullNameController.text = student.fullName ?? '';
      majorsController.text = student.majors ?? '';
      selectedStudy.value = student.studyProgram;
    }

    if (_studentController.student.value == null) {
      _studentController.getMyData();
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (selectedLanguage.isNotEmpty) TranslationService.changeLocale(selectedLanguage.value);
    if (selectedTheme.isNotEmpty) changeTheme(selectedTheme.value);
  }

  void toggleTab(bool userTab) => isStudentTab.value = userTab;

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
    TranslationService.changeLocale(lang);
    GetStorage().write('language', lang);
  }

  void changeTheme(String theme) {
    selectedTheme.value = theme;
    if (theme == 'System') {
      Get.changeThemeMode(ThemeMode.system);
    } else if (theme == 'Light') {
      Get.changeThemeMode(ThemeMode.light);
    } else if (theme == 'Dark') {
      Get.changeThemeMode(ThemeMode.dark);
    }
    GetStorage().write('theme', theme);
  }

  /// ======= UPDATE USER DATA =========
  Future<void> updateUserData() async {
    isLoading.value = true;
    try {
      await _userController.updateMyUserData(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );
      await _userController.getMyData();

      // Update kembali ke form
      final updatedUser = _userController.user.value;
      usernameController.text = updatedUser?.username ?? '';
      emailController.text = updatedUser?.email ?? '';

      if (updatedUser != null) LocalStorageService.saveUser(updatedUser);

      Get.snackbar('Success', 'Update data user berhasil!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// ======= UPDATE STUDENT DATA =========
  Future<void> updateStudentData() async {
    isLoading.value = true;
    try {
      await _studentController.updateMyStudentData(
        int.parse(nimController.text),
        fullNameController.text,
        majorsController.text,
        selectedStudy.value ?? '',
      );
      await _studentController.getMyData();

      // Update kembali ke form
      final updatedStudent = _studentController.student.value;
      nimController.text = updatedStudent?.nim.toString() ?? '';
      fullNameController.text = updatedStudent?.fullName ?? '';
      majorsController.text = updatedStudent?.majors ?? '';
      selectedStudy.value = updatedStudent?.studyProgram;

      if (updatedStudent != null) LocalStorageService.saveStudent(updatedStudent);

      Get.snackbar('Success', 'Update data student berhasil!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    LocalStorageService.clearAll();
    Get.offAllNamed(Routes.LOGIN);
  }
}
