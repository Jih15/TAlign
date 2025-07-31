import 'package:flutter/material.dart';
import 'package:frontend/app/modules/profile/controllers/profile_controller.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:frontend/utils/widgets/custom_dropdownfield.dart';
import 'package:frontend/utils/widgets/custom_textfield2.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditStudentForm extends GetView<ProfileController>{
  const EditStudentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final studyProgram = [
      'D4 - Teknologi Rekayasa Perangkat Lunak',
      'D4 - Animasi',
      'D3 - Teknologi Komputer',
      'D3 - Manajemen Informatika',
      'D3 - Sistem Informasi',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(12),
        Text(
          'Your Student Data',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Gap(20),

        CustomTextField2(
          controller: controller.nimController,
          hintText: 'Enter your NIM!',
          fillColorOverride: isDarkMode ? ThemeApp.grayscaleAltMedium : const Color(0xFFF5F5F5),
        ),
        const Gap(16),

        CustomTextField2(
          controller: controller.fullNameController,
          hintText: 'Enter your full name!',
          fillColorOverride: isDarkMode ? ThemeApp.grayscaleAltMedium : const Color(0xFFF5F5F5),
        ),
        const Gap(16),
        CustomTextField2(
          controller: controller.majorsController,
          hintText: 'Majors',
          enabled: false,
          fillColorOverride: isDarkMode ? ThemeApp.grayscaleAltMedium : const Color(0xFFF5F5F5),
        ),
        const Gap(16),
        CustomDropdownField(
          hint: 'Prodi',
          items: studyProgram,
          value: controller.selectedStudy.value,
          onChanged: (val) => controller.selectedStudy.value = val,
          itemBuilder: (item) => Text(
            item,
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          borderColor: isDarkMode ? Colors.transparent : Colors.grey.shade300,
          fillColor: isDarkMode ? ThemeApp.grayscaleAltMedium : const Color(0xFFF5F5F5),
        ),

        const Gap(56),

        // Login Button
        Obx(() => SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFFD7680D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {
              controller.updateStudentData();
            },
            child: controller.isLoading.value
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
                : Text(
              'Save',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        )),
        // Obx(() => SizedBox(
        //   width: double.infinity,
        //   child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       padding: const EdgeInsets.symmetric(vertical: 16),
        //       backgroundColor: const Color(0xFFD7680D),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(50),
        //       ),
        //     ),
        //     onPressed: () {
        //       controller.checkStorage();
        //     },
        //     child: controller.isLoading.value
        //       ? const SizedBox(
        //           width: 20,
        //           height: 20,
        //           child: CircularProgressIndicator(
        //             color: Colors.white,
        //             strokeWidth: 2,
        //           ),
        //         )
        //       : Text(
        //           'Login',
        //           style: TextStyle(fontSize: 16, color: Colors.white),
        //         ),
        //   ),
        // ))
      ],
    );
  }
}