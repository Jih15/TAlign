import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:frontend/app/data/models/gemini-generate/generate_judul_response_model.dart';
import 'package:frontend/utils/services/dio_client.dart';

class GeminiService {
  final Dio _dio = dioClient;

  Future<GenerateResponseModel> generateJudul(String bidang) async {
    try {
      final response = await _dio.post(
        'generate-judul/',
        data: {'bidang': bidang},
      );

      print('[DIO RAW STATUS] ${response.statusCode}');
      print('[DIO RAW HEADERS] ${response.headers}');
      print('[DIO RAW DATA] ${response.data.runtimeType} | ${response.data}');

      final raw = response.data;
      final decoded = raw is String ? jsonDecode(raw) : raw;

      return GenerateResponseModel.fromJson(decoded);
    } on DioException catch (e) {
      print('[DIO ERROR] ${e.message}');
      print('[DIO RESPONSE] ${e.response?.statusCode} | ${e.response?.data}');
      print('[DIO STACKTRACE] ${e.stackTrace}');
      rethrow;
    }

  }

}
