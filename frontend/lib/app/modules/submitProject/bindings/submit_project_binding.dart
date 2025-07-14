import 'package:get/get.dart';

import '../controllers/submit_project_controller.dart';

class SubmitProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmitProjectController>(
      () => SubmitProjectController(),
    );
  }
}
