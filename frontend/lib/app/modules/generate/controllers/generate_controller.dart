import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:frontend/app/data/models/gemini-generate/generate_judul_response_model.dart';
import 'package:frontend/app/data/services/gemini_service.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:get/get.dart';

class GenerateController extends GetxController {
  final GeminiService _geminiServices = GeminiService();

  final RxString bgImagePath = ''.obs;
  final isLoading = false.obs;
  final RxList<String> judulList = <String>[].obs;

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

  Future<void> generateJudul(String field) async {
    try {
      isLoading.value = true;
      judulList.clear();

      final GenerateResponseModel response = await _geminiServices.generateJudul(field);
      judulList.assignAll(response.data); // List<String>
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
