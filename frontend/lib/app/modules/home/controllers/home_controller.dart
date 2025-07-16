import 'package:flutter/material.dart';
import 'package:frontend/app/data/controller/user_controller.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final UserController _userController = Get.find<UserController>();

  final TextEditingController controller = TextEditingController();
  final RxString bgImagePath = ''.obs;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void setBgImg(bool isDarkMode) {
    bgImagePath.value = isDarkMode
        ? ConstantAssets.imgBgDark
        : ConstantAssets.imgBgLight;
  }

  void fetchUser() async {
    try {
      await _userController.getMyData();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  String? get username => _userController.user.value?.username;
}
