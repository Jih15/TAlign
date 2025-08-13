import 'dart:io';

import 'package:frontend/app/data/models/table/submission_model.dart';
import 'package:frontend/app/data/services/submission_services.dart';
import 'package:get/get.dart';

class SubmissionController extends GetxController{
  final Rxn<SubmissionModel> submission = Rxn<SubmissionModel>();

  Future<void> getMySubmission() async {
    try {
      final submission = await SubmissionServices().getMySubmission();
      this.submission.value = submission;
      print('[SUB CONTROLLER] Data submission berhasil diambil');
    } catch (e) {
      print('[SUB CONTROLLER] Error: $e');
    }
  }

  Future<void> uploadMySubmission(
      File? document,
      String title,
      String titleField,
      String ideaSource,
      ) async {
    try {
      final submission = await SubmissionServices().uploadMySubmission(
          title: title,
          titleField: titleField,
          ideaSource: ideaSource,
          document: document
      );
      this.submission.value = submission;
      print('[SUB CONTROLLER] Data submission berhasil diupload');
    } catch (e) {
      print('[SUB CONTROLLER] Error: $e');
    }
  }
}