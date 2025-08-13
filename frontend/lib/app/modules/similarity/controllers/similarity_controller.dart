import 'package:flutter/material.dart';
import 'package:frontend/app/data/controller/similarity_data_controller.dart';
import 'package:get/get.dart';

class SimilarityController extends GetxController {
  final SimilarityDataController dataController = Get.find<SimilarityDataController>();

  final isLoading = false.obs;
  final projectTitle = TextEditingController();

  Future<void> onCheckSimilarity() async {
    final judul = projectTitle.text.trim();
    if (judul.isEmpty) {
      Get.snackbar(
        "Error",
        "Judul tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    try {
      await dataController.checkSimilarity(judul, 30);
    } finally {
      isLoading.value = false;
    }
  }
}
