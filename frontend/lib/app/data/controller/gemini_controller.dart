import 'package:frontend/app/data/services/gemini_service.dart';
import 'package:get/get.dart';

class GeminiController extends GetxController {
  final GeminiService _geminiService = GeminiService();

  final RxList<String> judulList = <String>[].obs;
  final isLoading = false.obs;

  Future<void> generateJudul(String field) async {
    isLoading.value = true;
    try {
      final result = await _geminiService.generateJudul(field);
      judulList.assignAll(result.data);
    } catch (e) {
      print('[GEMINI CONTROLLER] Error saat generate judul: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
