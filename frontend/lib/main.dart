import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/services/translation_services.dart';
import 'package:frontend/utils/constant_value.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(
    // GetMaterialApp(
    //   title: "Application",
    //   initialRoute: AppPages.INITIAL,
    //   getPages: AppPages.routes,
    // ),
    MyApp()
    // Test()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      initialRoute: '/login',
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
