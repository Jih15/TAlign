import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/utils/services/token.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }

  Future<void> checkAuth() async {
    final loggedIn = await isAuthenticated();
    if (loggedIn) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
