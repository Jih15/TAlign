import 'package:Cek_Tugas_Akhir/app/modules/profile/widget/app_personalization.dart';
import 'package:Cek_Tugas_Akhir/app/modules/profile/widget/profile_card.dart';
import 'package:Cek_Tugas_Akhir/app/routes/app_pages.dart';
import 'package:Cek_Tugas_Akhir/utils/constant_assets.dart';
import 'package:Cek_Tugas_Akhir/utils/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setBgImg(isDarkMode);
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Profile and Settings'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(Routes.HOME);
          },
          icon: Image.asset(
            color: color.onSurface,
            ConstantAssets.icoBackDark,
            height: 32,
            width: 32,
            scale: 0.8,
          ),
        ),
      ),
      body: Obx(() {
        final imagePath = controller.bgImagePath.value;
        return Stack(
          children: [
            if (imagePath.isNotEmpty)
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: EdgeInsetsGeometry.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kToolbarHeight *2.5,),
                  Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: color.onSurface
                    ),
                  ),
                  Gap(16),
                  ProfileCard(),
                  Gap(24),
                  Text(
                    'App',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: color.onSurface
                    ),
                  ),
                  Gap(16),
                  AppPersonalization(),
                  Gap(24),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? ThemeApp.grayscaleMedium
                            : ThemeApp.grayscaleAltLight,
                        borderRadius: BorderRadius.circular(16),
                        border: isDarkMode
                            ? null
                            : Border.all(color: Colors.grey.shade400, width: 1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Us',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Gap(24),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color.error,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
