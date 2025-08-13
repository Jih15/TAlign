import 'package:frontend/app/data/controller/submission_controller.dart';
import 'package:get/get.dart';

import '../controllers/submit_project_controller.dart';

class SubmitProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmissionController>(() => SubmissionController());
    Get.lazyPut<SubmitProjectController>(
      () => SubmitProjectController(),
    );
  }
}
