import 'package:Cek_Tugas_Akhir/app/modules/profile/controllers/profile_controller.dart';
import 'package:Cek_Tugas_Akhir/utils/constant_assets.dart';
import 'package:Cek_Tugas_Akhir/utils/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AppPersonalization extends StatefulWidget {
  const AppPersonalization({super.key});

  @override
  State<AppPersonalization> createState() => _AppPersonalizationState();
}

class _AppPersonalizationState extends State<AppPersonalization> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final color = Theme.of(context).colorScheme;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width/3.1,
      decoration: BoxDecoration(
          color: isDarkMode
            ? ThemeApp.grayscaleMedium
            : ThemeApp.grayscaleAltLight,
          borderRadius: BorderRadius.circular(16),
          border: isDarkMode
            ? null
            : Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.dialog(
                  barrierDismissible: false,
                    Dialog(
                      backgroundColor: Colors.transparent,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDarkMode
                            ? ThemeApp.grayscaleMedium
                            : ThemeApp.grayscaleAltLight,
                          borderRadius: BorderRadius.circular(16),
                          border: isDarkMode
                            ? null
                            : Border.all(color: Colors.grey.shade400, width: 1)
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  isDarkMode
                                  ? ConstantAssets.icoLanguageDark : ConstantAssets.icoLanguageLight,
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.contain,
                                ),
                                Gap(4),
                                Text(
                                  'Language'.tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Gap(4),
                                Divider(
                                  color: ThemeApp.grayscaleAltDark,
                                ),
                                Gap(4),
                              ],
                            ),
                            Column(
                              children: ['English', 'Bahasa Indonesia'].map((lang) {
                                return ListTile(
                                  title: Text(lang),
                                  onTap: () {
                                    controller.changeLanguage(lang);
                                    Get.back();
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    )
                );
              },
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      isDarkMode
                        ? ConstantAssets.icoLanguageDark
                        : ConstantAssets.icoLanguageLight,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    Gap(16),
                    Expanded(
                      child: Text(
                        'Language'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      controller.selectedLanguage.value,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Gap(8),
                    Image.asset(
                      ConstantAssets.icoArrowRight,
                      width: 16,
                      height: 16,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Get.defaultDialog(
                  titlePadding: EdgeInsets.only(top: 20),
                  title: 'Select Theme'.tr,
                  titleStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
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
                  backgroundColor: isDarkMode
                    ? ThemeApp.grayscaleMedium
                    : ThemeApp.grayscaleAltLight,
                );
              },

              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      isDarkMode
                        ? ConstantAssets.icoAppearanceDark
                        : ConstantAssets.icoAppearanceLight,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    Gap(16),
                    Expanded(
                      child: Text(
                        'Appearance'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      controller.selectedTheme.value,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Gap(8),
                    Image.asset(
                      ConstantAssets.icoArrowRight,
                      width: 16,
                      height: 16,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}