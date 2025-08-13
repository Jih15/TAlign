import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:frontend/utils/constant_value.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:frontend/app/data/controller/student_controller.dart';
import 'package:frontend/app/data/controller/user_controller.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/core/local_storage_service.dart';
import 'package:frontend/services/translation_services.dart';

class ProfileController extends GetxController {
  final StudentController _studentController = Get.find<StudentController>();
  final UserController _userController = Get.find<UserController>();

  final RxString selectedLanguage = 'English'.obs;
  final RxString selectedTheme = 'System'.obs;

  // Form Student
  final nimController = TextEditingController();
  final fullNameController = TextEditingController();
  final majorsController = TextEditingController();
  final selectedStudy = RxnString();

  // Form User
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final Rxn<File> selectedImage = Rxn<File>();
  final RxBool isPasswordVisible = false.obs;
  final RxBool isStudentTab = true.obs;
  final RxBool isLoading = false.obs;

  // Getters untuk tampilan awal data
  String get fullName {
    final name = _studentController.student.value?.fullName;
    return (name != null && name.trim().isNotEmpty) ? name : 'Student';
  }

  String get majors {
    final m = _studentController.student.value?.majors;
    return (m != null && m.trim().isNotEmpty) ? m : 'Majors not filled yet';
  }

  String get studyProgram {
    final sp = _studentController.student.value?.studyProgram;
    return (sp != null && sp.trim().isNotEmpty)
        ? sp
        : 'Study Program not filled yet';
  }

  int? get nim => _studentController.student.value?.nim ?? 0;

  String? get profilePicture => _userController.user.value?.profilePicture;

  String get username {
    final u = _userController.user.value?.username;
    return (u != null && u.trim().isNotEmpty) ? u : 'Username';
  }

  String get email {
    final e = _userController.user.value?.email;
    return (e != null && e.trim().isNotEmpty) ? e : 'Email';
  }

  String? get fullImageUrl {
    final path = _userController.user.value?.profilePicture;
    if (path == null || path.trim().isEmpty) return null;
    return '${ConstantsValues.baseUrl}${path.startsWith('/') ? path.substring(1) : path}';
  }

  @override
  void onInit() {
    super.onInit();

    final storedLang = GetStorage().read('language');
    if (storedLang != null) selectedLanguage.value = storedLang;

    final storedTheme = GetStorage().read('theme');
    if (storedTheme != null) selectedTheme.value = storedTheme;

    _initFormData();
  }

  void _initFormData() {
    final user = _userController.user.value;
    if (user != null) {
      usernameController.text =
      (user.username.trim().isNotEmpty)
          ? user.username
          : '';
      emailController.text =
      (user.email.trim().isNotEmpty)
          ? user.email
          : '';
    }

    final student = _studentController.student.value;
    if (student != null) {
      nimController.text = student.nim?.toString() ?? '';
      fullNameController.text =
      (student.fullName != null && student.fullName!.trim().isNotEmpty)
          ? student.fullName!
          : '';
      majorsController.text =
      (student.majors != null && student.majors!.trim().isNotEmpty)
          ? student.majors!
          : '';
      selectedStudy.value = student.studyProgram;
    } else {
      _studentController.getMyData();
    }
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

  void toggleTab(bool isStudentSelected) {
    isStudentTab.value = isStudentSelected;
  }

  void changeLanguage(String lang) {
    selectedLanguage.value = lang;
    TranslationService.changeLocale(lang);
    GetStorage().write('language', lang);
  }

  void changeTheme(String theme) {
    selectedTheme.value = theme;
    ThemeMode mode;
    if (theme == 'System') {
      mode = ThemeMode.system;
    } else if (theme == 'Light') {
      mode = ThemeMode.light;
    } else {
      mode = ThemeMode.dark;
    }
    Get.changeThemeMode(mode);
    GetStorage().write('theme', theme);
  }

  Future<void> pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        selectedImage.value = File(result.files.single.path!);
      } else {
        Get.snackbar('Info', 'Tidak ada gambar dipilih');
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal memilih gambar: $e');
    }
  }

  Future<void> sendEmail() async {
    final Email email = Email(
      body: 'Halo, saya ingin melakukan pengaduan.',
      subject: 'Pengaduan Aplikasi',
      recipients: ['zaqazaqaul@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print('Failed to send email: $error');
    }
  }

  Future<void> updateUserData() async {
    isLoading.value = true;
    try {
      await _userController.updateMyUserData(
        selectedImage.value,
        usernameController.text,
        emailController.text,
        passwordController.text,
      );

      await _userController.getMyData();

      final updatedUser = _userController.user.value;
      usernameController.text =
      (updatedUser?.username != null &&
          updatedUser!.username.trim().isNotEmpty)
          ? updatedUser.username
          : '';
      emailController.text =
      (updatedUser?.email != null &&
          updatedUser!.email.trim().isNotEmpty)
          ? updatedUser.email
          : '';

      if (updatedUser != null) {
        LocalStorageService.saveUser(updatedUser);
      }

      Get.snackbar('Success', 'Update data user berhasil!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateStudentData() async {
    isLoading.value = true;
    try {
      await updateUserData();

      await _studentController.updateMyStudentData(
        int.parse(nimController.text),
        fullNameController.text,
        majorsController.text,
        selectedStudy.value ?? '',
      );

      await _studentController.getMyData();

      final updatedStudent = _studentController.student.value;
      nimController.text = updatedStudent?.nim?.toString() ?? '';
      fullNameController.text =
      (updatedStudent?.fullName != null &&
          updatedStudent!.fullName!.trim().isNotEmpty)
          ? updatedStudent.fullName!
          : '';
      majorsController.text =
      (updatedStudent?.majors != null &&
          updatedStudent!.majors!.trim().isNotEmpty)
          ? updatedStudent.majors!
          : '';
      selectedStudy.value = updatedStudent?.studyProgram;

      if (updatedStudent != null) {
        LocalStorageService.saveStudent(updatedStudent);
      }

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

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nimController.dispose();
    fullNameController.dispose();
    majorsController.dispose();
    super.onClose();
  }
}
