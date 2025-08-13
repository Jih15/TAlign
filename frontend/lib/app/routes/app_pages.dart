import 'package:get/get.dart';

import '../modules/generate/bindings/generate_binding.dart';
import '../modules/generate/views/generate_view.dart';
import '../modules/generateResult/bindings/generate_result_binding.dart';
import '../modules/generateResult/views/generate_result_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/similarity/bindings/similarity_binding.dart';
import '../modules/similarity/views/similarity_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/submitProject/bindings/submit_project_binding.dart';
import '../modules/submitProject/views/submit_project_view.dart';
import '../modules/test/bindings/test_binding.dart';
import '../modules/test/views/test_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      // transition: Transition.native
    ),
    GetPage(
      name: _Paths.TEST,
      page: () => TestView(),
      binding: TestBinding(),
      // transition: Transition.native,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft
    ),
    GetPage(
      name: _Paths.GENERATE,
      page: () => const GenerateView(),
      binding: GenerateBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIMILARITY,
      page: () => const SimilarityView(),
      binding: SimilarityBinding(),
    ),
    GetPage(
      name: _Paths.SUBMIT_PROJECT,
      page: () => const SubmitProjectView(),
      binding: SubmitProjectBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.GENERATE_RESULT,
      page: () => const GenerateResultView(),
      binding: GenerateResultBinding(),
    ),
  ];
}
