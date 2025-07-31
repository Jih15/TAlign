import 'package:flutter/cupertino.dart';
import 'package:frontend/app/data/controller/auth_controller.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/core/local_storage_service.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  final RxString bgImagePath = ''.obs;
  final rememberMe = false.obs;
  final isLoading = false.obs;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;

  var isLogin = true.obs;

  void toggleTab(bool login){
    isLogin.value = login;  
  }

  void setBgImg(bool isDarkMode) {
    bgImagePath.value = isDarkMode
        ? ConstantAssets.imgBgDark
        : ConstantAssets.imgBgLight;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Username dan password tidak boleh kosong!');
      return;
    }
    isLoading.value = true;
    try {
      await _authController.login(username, password);
      Get.snackbar('Success', 'Login berhasil!');
      Get.offNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar('Login gagal', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void signUp() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Field tidak boleh kosong');
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
