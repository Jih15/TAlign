import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend/app/data/models/table/submission_model.dart';
import 'package:frontend/utils/services/dio_client.dart';

class SubmissionServices {
  final Dio _dio = dioClient;

  Future<SubmissionModel> getMySubmission () async {
    try {
      final response = await _dio.get('submissions/me');
      return SubmissionModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = e.response?.data['detail'] ?? 'Error fetch submission!';
      throw Exception(errorMessage);
    }
  }

  Future<SubmissionModel> uploadMySubmission({
    required String title,
    required String titleField,
    required ideaSource,
    required File? document,
  }) async {
    try {
      final formData = FormData();

      formData.fields.addAll([
        MapEntry('title', title),
        MapEntry('titleField', titleField),
        MapEntry('ideaSource', ideaSource),
      ]);

      if (document != null) {
        formData.files.add(MapEntry(
          'document',
          await MultipartFile.fromFile(document.path),
        ));
      }

      final response = await _dio.post(
        'submissions/',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      return SubmissionModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = e.response?.data['detail'] ?? 'Error upload submission!';
      throw Exception(errorMessage);
    }
  }
}