import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SimilarityController extends GetxController {
  //TODO: Implement SimilarityController

  final isLoading = false.obs;

  final projectTitle = TextEditingController();

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

  void increment() => count.value++;
}
