import 'package:easy_radio/easy_radio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:frontend/utils/widgets/background_wrapper.dart';
import 'package:frontend/utils/widgets/custom_dropdownfield.dart';
import 'package:frontend/utils/widgets/custom_fileUpload.dart';
import 'package:frontend/utils/widgets/custom_textfield2.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../controllers/submit_project_controller.dart';

class SubmitProjectView extends GetView<SubmitProjectController> {
  const SubmitProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fields = [
      'Artificial Intelligence',
      'Web Development',
      'Mobile Development',
      'Internet of Things',
      'Cybersecurity',
      'Data Science',
      'Machine Learning',
      'Blockchain'
    ];

    final selectedField = RxnString();
    final RxString lecturerIdea = ''.obs;

    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Submit Project'),
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
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kToolbarHeight * 0.2),
                const Text(
                  'Submit Project\nIdeas',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(16),
                const Text(
                  'Submit your project ideas for review by\nKBK team',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Gap(36),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomDropdownField(
                        hint: 'Field',
                        items: fields,
                        value: selectedField.value,
                        onChanged: (val) => controller.selectedField.value = val,
                        itemBuilder: (item) => Text(
                          item,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      const Gap(20),
                      CustomTextField2(
                        controller: controller.projectTitleController,
                        hintText: 'Project Title',
                      ),
                      const Gap(20),
                      CustomFileUpload(
                        label: "Drop file here",
                        onFilePicked: (fileName) {
                          debugPrint("File dipilih: $fileName");
                        },
                      ),
                      const Gap(20),
                      const Text('Was this title the lecturer\'s idea?'),
                      // const Gap(8),
                      Obx(() => Row(
                        children: [
                          Radio<String>(
                            activeColor: isDarkMode ? Colors.white : Colors.black,
                            value: 'Yes',
                            groupValue: controller.lecturerIdea.value,
                            onChanged: (value) => controller.lecturerIdea.value = value!,
                          ),
                          const Text('Yes'),
                          const SizedBox(width: 20),
                          Radio<String>(
                            activeColor: isDarkMode ? Colors.white : Colors.black,
                            value: 'No',
                            groupValue: controller.lecturerIdea.value,
                            onChanged: (value) => controller.lecturerIdea.value = value!,
                          ),
                          const Text('No'),
                        ],
                      )),

                      Gap(4),
                      CustomTextField2(
                        controller: controller.lecturerNameController,
                        hintText: 'Lecturer\'s Name',
                      ),
                      const Gap(48),
                      Center(
                        child: Obx(
                              () => SizedBox(
                            width: 360,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: ThemeApp.greenSoft,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              onPressed: () {
                                debugPrint(
                                    "Pilihan Lecturer Idea: ${lecturerIdea.value}");
                              },
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
