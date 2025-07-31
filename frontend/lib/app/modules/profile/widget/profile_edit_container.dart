
import 'package:frontend/app/modules/profile/controllers/profile_controller.dart';
import 'package:frontend/app/modules/profile/widget/form/edit_student_form.dart';
import 'package:frontend/app/modules/profile/widget/form/edit_user_form.dart';
import 'package:frontend/app/modules/profile/widget/user_student_switcher.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileEditContainer extends GetView<ProfileController>{
  const ProfileEditContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight = screenHeight - 300;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: screenWidth - 24,
      height: containerHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? ThemeApp.grayscaleMedium : ThemeApp.grayscaleAltLight,
        border: isDarkMode
            ? Border.all(color: Colors.transparent)
            : Border.all(color: const Color(0xFFEBEBEB)),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(44),
          topRight: Radius.circular(44),
        ),
        boxShadow: [
          if (isDarkMode)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          else
            const BoxShadow(color: Colors.transparent),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UserStudentSwitcher(
            isUserTab: controller.isStudentTab,
            onToggle: controller.toggleTab,
            width: screenWidth - 16,
          ),
          const Gap(20),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                return controller.isStudentTab.value
                    ? EditStudentForm()
                    : EditUserForm();
              }),
            ),
          )
        ],
      ),
    );
  }
}