import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:get/get.dart';

class GenerateController extends GetxController {
  //TODO: Implement GenerateController
  final RxString bgImagePath = ''.obs;

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
}
