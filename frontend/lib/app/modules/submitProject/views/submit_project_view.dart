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

                /// Field Selection
                CustomDropdownField(
                  hint: 'Field',
                  items: fields,
                  value: controller.selectedField.value,
                  onChanged: (val) => controller.selectedField.value = val,
                  itemBuilder: (item) => Text(
                    item,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const Gap(20),

                /// Project Title
                CustomTextField2(
                  controller: controller.projectTitleController,
                  hintText: 'Project Title',
                ),
                const Gap(20),

                /// File Upload
                Obx(() => CustomFileUpload(
                  label: controller.selectedDocument.value != null
                      ? controller.selectedDocument.value!.path.split('/').last
                      : "Drop file here",
                  onFilePicked: (fileName) async {
                    await controller.pickDocument();
                  },
                )),
                const Gap(20),

                /// Lecturer's Idea? Yes/No
                const Text('Was this title the lecturer\'s idea?'),
                Obx(() => Row(
                  children: [
                    Radio<String>(
                      activeColor: isDarkMode ? Colors.white : Colors.black,
                      value: 'Yes',
                      groupValue: controller.lecturerIdea.value,
                      onChanged: (value) {
                        controller.lecturerIdea.value = value!;
                        controller.ideaSource.value = 'LECTURER_ADVICE';
                      },
                    ),
                    const Text('Yes'),
                    const SizedBox(width: 20),
                    Radio<String>(
                      activeColor: isDarkMode ? Colors.white : Colors.black,
                      value: 'No',
                      groupValue: controller.lecturerIdea.value,
                      onChanged: (value) {
                        controller.lecturerIdea.value = value!;
                        controller.ideaSource.value = '';
                      },
                    ),
                    const Text('No'),
                  ],
                )),

                /// If Yes → Lecturer Name Field
                Obx(() {
                  if (controller.lecturerIdea.value == 'Yes') {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: CustomTextField2(
                        controller: controller.lecturerNameController,
                        hintText: 'Lecturer\'s Name',
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),

                /// If No → Generated / Manual
                Obx(() {
                  if (controller.lecturerIdea.value == 'No') {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(12),
                        const Text('Select Idea Source:'),
                        Row(
                          children: [
                            Radio<String>(
                              activeColor: isDarkMode ? Colors.white : Colors.black,
                              value: 'GENERATED',
                              groupValue: controller.ideaSource.value,
                              onChanged: (value) => controller.ideaSource.value = value!,
                            ),
                            const Text('Generated'),
                            const SizedBox(width: 20),
                            Radio<String>(
                              activeColor: isDarkMode ? Colors.white : Colors.black,
                              value: 'MANUAL',
                              groupValue: controller.ideaSource.value,
                              onChanged: (value) => controller.ideaSource.value = value!,
                            ),
                            const Text('Manual'),
                          ],
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }),

                const Gap(36),

                /// Submit Button
                Center(
                  child: Obx(
                        () => SizedBox(
                      width: 320,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: ThemeApp.greenSoft,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          controller.submitProject();
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
        ),
      ),
    );
  }
}
