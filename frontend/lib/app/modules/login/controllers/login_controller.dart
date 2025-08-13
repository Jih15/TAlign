import 'package:flutter/material.dart';
import 'package:frontend/app/data/controller/auth_controller.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/core/local_storage_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  final rememberMe = false.obs;
  final isLoading = false.obs;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isLogin = true.obs;

  // Tambahan untuk error handling password
  var passwordError = ''.obs;
  var usernameError = ''.obs;

  void toggleTab(bool login) {
    isLogin.value = login;
  }

  @override
  void onInit() {
    super.onInit();
    // Hilangkan error saat user mengetik ulang password
    passwordController.addListener(() {
      if (passwordError.value.isNotEmpty) {
        passwordError.value = '';
      }
    });
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    passwordError.value = ''; // reset error

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
          'Error',
          'Username dan password tidak boleh kosong!',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.black
      );
      return;
    }
    isLoading.value = true;
    try {
      await _authController.login(username, password);
      Get.snackbar('Success', 'Login berhasil!', snackPosition: SnackPosition.BOTTOM);
      Get.offNamed(Routes.HOME);
    } catch (e) {
      if (e.toString().contains("Invalid password")) {
        passwordError.value = 'Incorrect Password';
      }
      if (e.toString().contains("Invalid username")) {
        usernameError.value = 'Incorrect Username';
      }
      // Get.snackbar(
      //     'Login gagal',
      //     e.toString(),
      //     snackPosition: SnackPosition.BOTTOM,
      //     colorText: Colors.black
      // );
    } finally {
      isLoading.value = false;
    }
  }

  void signUp() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Field tidak boleh kosong', snackPosition: SnackPosition.BOTTOM, colorText: Colors.black);
      return;
    }
    isLoading.value = true;
    try {
      await _authController.signUp(username, email, password);
      Get.snackbar('Success', 'Sign Up berhasil!');
      Get.offNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar('Sign Up gagal', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void checkStorage() {
    final token = LocalStorageService.getToken();
    final user = LocalStorageService.getUser();
    final student = LocalStorageService.getStudent();

    print('[STORAGE CHECK] Token: $token');
    print('[STORAGE CHECK] User: ${user?.username ?? "No user"}');
    print('[STORAGE CHECK] Student: ${student?.studentId ?? "No student"}');

    Get.snackbar(
      'Storage Check',
      'Token: ${token ?? "null"}\nUser: ${user?.username ?? "null"}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
