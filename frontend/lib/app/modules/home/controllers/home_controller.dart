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

    Future.microtask(() async {
      if (_userController.user.value == null) {
        await _userController.getMyData();
      }
    });
  }

  void setBgImg(bool isDarkMode) {
    bgImagePath.value = isDarkMode
        ? ConstantAssets.imgBgDark
        : ConstantAssets.imgBgLight;
  }

  String? get username => _userController.user.value?.username;
}



// import 'package:frontend/app/data/controller/user_controller.dart';
// import 'package:get/get.dart';
//
// class HomeController extends GetxController {
//   final UserController _userController = Get.find<UserController>();
//
//   final RxString bgImagePath = ''.obs;
//
//   String? get username => _userController.user.value?.username;
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     if (_userController.user.value == null){
//       _userController.getMyData();
//     }
//   }
// }
