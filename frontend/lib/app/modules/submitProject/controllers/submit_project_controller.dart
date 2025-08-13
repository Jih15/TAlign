import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/data/controller/submission_controller.dart';
import 'package:get/get.dart';

class SubmitProjectController extends GetxController {
  final SubmissionController _submissionController = Get.find<SubmissionController>();

  // State
  final isLoading = false.obs;
  final selectedField = RxnString(); // Bisa null awalnya
  final lecturerIdea = ''.obs; // "Yes" / "No"
  final ideaSource = ''.obs; // "GENERATED" / "MANUAL" / "LECTURER_ADVICE"

  final Rxn<File> selectedDocument = Rxn<File>();

  // Text Controllers
  final projectTitleController = TextEditingController();
  final lecturerNameController = TextEditingController();

  /// Pick document
  Future<void> pickDocument() async {
    try {
      final doc = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (doc != null && doc.files.single.path != null) {
        selectedDocument.value = File(doc.files.single.path!);
        debugPrint("File dipilih: ${selectedDocument.value!.path}");
      }
    } catch (e) {
      debugPrint("Error pilih file: $e");
    }
  }

  /// Submit project
  Future<void> submitProject() async {
    if (projectTitleController.text.isEmpty) {
      Get.snackbar("Error", "Project title is required");
      return;
    }
    if (selectedField.value == null || selectedField.value!.isEmpty) {
      Get.snackbar("Error", "Please select a field");
      return;
    }
    if (lecturerIdea.value.isEmpty) {
      Get.snackbar("Error", "Please choose Yes or No for lecturer's idea");
      return;
    }
    if (lecturerIdea.value == 'Yes' && lecturerNameController.text.isEmpty) {
      Get.snackbar("Error", "Lecturer's name is required");
      return;
    }
    if (lecturerIdea.value == 'No' && ideaSource.value.isEmpty) {
      Get.snackbar("Error", "Please choose Generated or Manual");
      return;
    }
    if (selectedDocument.value == null) {
      Get.snackbar("Error", "Please upload a file");
      return;
    }

    isLoading.value = true;
    try {
      await _submissionController.uploadMySubmission(
        selectedDocument.value!,
        projectTitleController.text,
        selectedField.value ?? '',
        ideaSource.value,
        // lecturerName: lecturerNameController.text,
      );

      Get.snackbar("Success", "Project submitted successfully");
      clearForm();
    } catch (e) {
      Get.snackbar("Error", "Failed to submit project");
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear all form values
  void clearForm() {
    projectTitleController.clear();
    lecturerNameController.clear();
    selectedField.value = null;
    lecturerIdea.value = '';
    ideaSource.value = '';
    selectedDocument.value = null;
  }

  @override
  void onClose() {
    projectTitleController.dispose();
    lecturerNameController.dispose();
    super.onClose();
  }
}
