import 'package:get/get.dart';

import '../controllers/similarity_controller.dart';

class SimilarityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SimilarityController>(
      () => SimilarityController(),
    );
  }
}
