import 'package:frontend/app/data/models/similarity_fuzzy/similarity_model.dart';
import 'package:frontend/app/data/services/similarity_service.dart';
import 'package:get/get.dart';

class SimilarityDataController extends GetxController {
  final SimilarityService _similarityService = SimilarityService();

  final Rxn<SimilarityResponseModel> similarityResponse = Rxn<SimilarityResponseModel>();

  Future<void> checkSimilarity(String judul, int threshold) async {
    try {
      final response = await _similarityService.checkMySimilarity(judul, threshold);
      similarityResponse.value = response;
      print('[FUZZ DATA CONTROLLER] Success');
    } catch (e) {
      print('[FUZZ DATA CONTROLLER] Error: $e');
      rethrow;
    }
  }
}
