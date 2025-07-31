import 'package:flutter/material.dart';
import 'package:frontend/app/modules/profile/controllers/profile_controller.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:frontend/utils/widgets/custom_textfield2.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditUserForm extends GetView<ProfileController> {
  const EditUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(12),
        Text(
          'Your User Data',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const Gap(20),

        // Username
        CustomTextField2(
          controller: controller.usernameController,
          hintText: 'Enter your Username',
          fillColorOverride:
          isDarkMode ? ThemeApp.grayscaleAltMedium : const Color(0xFFF5F5F5),
        ),
        const Gap(16),

        // Email
        CustomTextField2(
          controller: controller.emailController,
          hintText: 'Enter your email',
          fillColorOverride:
          isDarkMode ? ThemeApp.grayscaleAltMedium : const Color(0xFFF5F5F5),
        ),
        const Gap(16),

        // Password
        CustomTextField2(
          isPassword: true,
          isPasswordVisible: controller.isPasswordVisible,
          controller: controller.passwordController,
          hintText: 'Enter your password',
          fillColorOverride:
          isDarkMode ? ThemeApp.grayscaleAltMedium : const Color(0xFFF5F5F5),
        ),

        const Gap(56),

        // Save button
        Obx(
              () => SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFFD7680D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: controller.isLoading.value
                  ? null
                  : () => controller.updateUserData(),
              child: controller.isLoading.value
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : const Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
