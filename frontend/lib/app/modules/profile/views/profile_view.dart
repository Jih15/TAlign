import 'package:flutter/material.dart';
import 'package:frontend/app/modules/profile/widget/app_personalization.dart';
import 'package:frontend/app/modules/profile/widget/profile_edit_container.dart';
import 'package:frontend/app/modules/profile/widget/profile_image.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:frontend/utils/widgets/background_wrapper.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Profile and Settings'),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.offNamed(Routes.HOME),
            icon: Image.asset(
              ConstantAssets.icoBackDark,
              color: color.onSurface,
              height: 32,
              width: 32,
              scale: 0.8,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kToolbarHeight * 2),
                Center(
                  child: Column(
                    children: [
                      ProfileAvatarWithEditButton(
                        imageUrl: ConstantAssets.imgProfile,
                      ),
                      const Gap(8),
                      Obx(() => Text(
                        '${controller.fullName} (${controller.username})',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      Obx(() => Text(
                        '${controller.nim}',
                        style: const TextStyle(fontSize: 16),
                      )),

                      Gap(8),
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const ProfileEditContainer(),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Edit data',
                              style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                decorationColor: ThemeApp.greenSoft,
                                color: ThemeApp.greenSoft,
                              ),
                            ),
                            Gap(2),
                            Icon(
                              Icons.edit,
                              size: 16,
                              color: ThemeApp.greenSoft,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const Gap(24),
                // Text(
                //   'Profile',
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w600,
                //     color: color.onSurface,
                //   ),
                // ),
                // const Gap(16),
                // _buildMenuItem(
                //   context,
                //   label: 'Edit Profile',
                //   isDarkMode: isDarkMode,
                //   onTap: () {
                //   },
                // ),
                const Gap(24),
                Text(
                  'App',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color.onSurface,
                  ),
                ),
                const Gap(16),
                const AppPersonalization(),
                const Gap(16),
                _buildMenuItem(
                  context,
                  label: 'Feedback',
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
                const Gap(16),
                _buildMenuItem(
                  context,
                  label: 'Contact Us',
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
                const Gap(16),
                GestureDetector(
                  onTap: controller.logout,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color.error,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required String label,
        required bool isDarkMode,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
          isDarkMode ? ThemeApp.grayscaleMedium : ThemeApp.grayscaleAltLight,
          borderRadius: BorderRadius.circular(16),
          border: isDarkMode
              ? null
              : Border.all(color: Colors.grey.shade400, width: 1),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
