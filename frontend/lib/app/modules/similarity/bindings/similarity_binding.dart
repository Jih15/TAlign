import 'package:frontend/app/data/controller/similarity_data_controller.dart';
import 'package:get/get.dart';

import '../controllers/similarity_controller.dart';

class SimilarityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SimilarityDataController>(() => SimilarityDataController());
    Get.lazyPut<SimilarityController>(
      () => SimilarityController(),
    );
  }
}
