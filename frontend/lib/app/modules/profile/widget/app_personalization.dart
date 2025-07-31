import 'package:flutter/material.dart';
import 'package:frontend/app/modules/profile/controllers/profile_controller.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AppPersonalization extends GetView<ProfileController> {
  const AppPersonalization({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDarkMode ? ThemeApp.grayscaleMedium : ThemeApp.grayscaleAltLight,
        borderRadius: BorderRadius.circular(16),
        border: isDarkMode
            ? null
            : Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Language Selector
          // GestureDetector(
          //   onTap: () {
          //     Get.dialog(
          //       barrierDismissible: false,
          //       Dialog(
          //         backgroundColor: Colors.transparent,
          //         child: Container(
          //           padding: const EdgeInsets.all(16),
          //           decoration: BoxDecoration(
          //             color: isDarkMode
          //                 ? ThemeApp.grayscaleMedium
          //                 : ThemeApp.grayscaleAltLight,
          //             borderRadius: BorderRadius.circular(16),
          //             border: isDarkMode
          //                 ? null
          //                 : Border.all(color: Colors.grey.shade400, width: 1),
          //           ),
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Image.asset(
          //                 isDarkMode
          //                     ? ConstantAssets.icoLanguageDark
          //                     : ConstantAssets.icoLanguageLight,
          //                 width: 24,
          //                 height: 24,
          //               ),
          //               const Gap(8),
          //               Text(
          //                 'Language'.tr,
          //                 style: const TextStyle(fontSize: 14),
          //               ),
          //               const Gap(8),
          //               const Divider(),
          //               ...['English', 'Bahasa Indonesia'].map((lang) {
          //                 return ListTile(
          //                   title: Text(lang),
          //                   onTap: () {
          //                     controller.changeLanguage(lang);
          //                     Get.back();
          //                   },
          //                 );
          //               }),
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 12),
          //     child: Row(
          //       children: [
          //         Image.asset(
          //           isDarkMode
          //               ? ConstantAssets.icoLanguageDark
          //               : ConstantAssets.icoLanguageLight,
          //           width: 24,
          //           height: 24,
          //         ),
          //         const Gap(16),
          //         Expanded(
          //           child: Text(
          //             'Language'.tr,
          //             style: const TextStyle(
          //               fontSize: 14,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //         ),
          //         Text(
          //           controller.selectedLanguage.value,
          //           style: const TextStyle(fontSize: 14),
          //         ),
          //         const Gap(8),
          //         Image.asset(
          //           ConstantAssets.icoArrowRight,
          //           width: 16,
          //           height: 16,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          /// Theme Selector
          GestureDetector(
            onTap: () {
              Get.defaultDialog(
                title: 'Select Theme'.tr,
                titleStyle: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600),
                backgroundColor: isDarkMode
                    ? ThemeApp.grayscaleMedium
                    : ThemeApp.grayscaleAltLight,
                content: Column(
                  children: ['System', 'Light', 'Dark'].map((theme) {
                    return ListTile(
                      title: Text(theme),
                      onTap: () {
                        controller.changeTheme(theme);
                        Get.back();
                      },
                    );
                  }).toList(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Image.asset(
                    isDarkMode
                        ? ConstantAssets.icoAppearanceDark
                        : ConstantAssets.icoAppearanceLight,
                    width: 24,
                    height: 24,
                  ),
                  const Gap(16),
                  Expanded(
                    child: Text(
                      'Appearance'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    controller.selectedTheme.value,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Gap(8),
                  Image.asset(
                    ConstantAssets.icoArrowRight,
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
