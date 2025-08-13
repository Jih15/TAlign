import 'package:dio/dio.dart';
import 'package:frontend/app/data/models/similarity_fuzzy/similarity_model.dart';
import 'package:frontend/utils/services/dio_client.dart';

class SimilarityService {
  final Dio _dio = dioClient;

  Future<SimilarityResponseModel> checkMySimilarity(String judul, int threshold) async {
    try {
      print('[FUZZ] Mengirim request similarity: judul=$judul, threshold=$threshold');

      final response = await _dio.post(
        'fuzzy/similarity-check',
        data: {
          "judul": judul,
          "threshold": threshold,
        },
      );

      print('[FUZZ] Response dari server: ${response.data}');

      return SimilarityResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      print('[FUZZ] Gagal similarity: ${e.response?.statusCode} - ${e.response?.data}');
      final errorMessage = e.response?.data['detail'] ?? 'Similarity failed!';
      throw Exception(errorMessage);
    } catch (e) {
      print('[FUZZ] Unexpected error: $e');
      rethrow;
    }
  }
}
