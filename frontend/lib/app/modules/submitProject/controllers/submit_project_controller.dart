import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitProjectController extends GetxController {
  // State
  final isLoading = false.obs;
  final selectedField = RxnString();
  final lecturerIdea = ''.obs;

  // Text Controllers
  final projectTitleController = TextEditingController();
  final lecturerNameController = TextEditingController();

  Future<void> submitProject() async {
    if (projectTitleController.text.isEmpty) {
      Get.snackbar("Error", "Project title is required");
      return;
    }
    if (lecturerIdea.value.isEmpty) {
      Get.snackbar("Error", "Please choose Yes or No for lecturer's idea");
      return;
    }

    isLoading.value = true;
    try {
      // TODO: Panggil API atau proses simpan di sini
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar("Success", "Project submitted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to submit project");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    projectTitleController.dispose();
    lecturerNameController.dispose();
    super.onClose();
  }
}
