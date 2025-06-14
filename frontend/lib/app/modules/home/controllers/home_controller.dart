import 'package:Cek_Tugas_Akhir/utils/constant_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final TextEditingController controller = TextEditingController();
  final RxString bgImagePath = ''.obs;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setBgImg(bool isDarkMode) {
    bgImagePath.value = isDarkMode
        ? ConstantAssets.imgBgDark
        : ConstantAssets.imgBgLight;
  }

  void increment() => count.value++;
}
