import 'package:get/get.dart';

import '../controllers/generate_result_controller.dart';

class GenerateResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateResultController>(
      () => GenerateResultController(),
    );
  }
}
