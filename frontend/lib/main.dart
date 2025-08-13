import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/core/local_storage_service.dart';
import 'package:frontend/services/translation_services.dart';
import 'package:frontend/utils/constant_value.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await GetStorage.init();

  final bool isLogin = await LocalStorageService.isAuthenticated();

  runApp(MyApp(initialRoute: isLogin ? Routes.HOME : Routes.LOGIN,));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: ConstantsValues.appName,
      translations: TranslationService(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      themeMode: ThemeMode.system,
      // initialRoute: Routes.LOGIN,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
    );
  }
}

// class Test extends StatelessWidget {
//   const Test({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: ConstantsValues.appName,
//       theme: ThemeApp.lightTheme,
//       darkTheme: ThemeApp.darkTheme,
//       themeMode: ThemeMode.system,
//       initialRoute: '/test',
//       getPages: AppPages.routes,
//     );
//   }
// }
