import 'package:flutter/material.dart';
import 'package:frontend/app/modules/generateResult/controllers/generate_result_controller.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:frontend/utils/widgets/custom_dropdownfield.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/generate_controller.dart';

class GenerateView extends GetView<GenerateController> {
  const GenerateView({super.key});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final fields = ['Artificial Intelligence', 'Web Development', 'Mobile Development', 'Internet of Things' , 'Cybersecurity' , 'Data Science' , 'Machine Learning' , 'Blockchain'];
    final difficulties = ['Easy', 'Medium', 'Hard'];

    final selectedField = RxnString();
    final selectedDifficulty = RxnString();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setBgImg(isDarkMode);
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Generate Ideas'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: (){
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
      body: Obx(() => Stack(
        children: [
          SizedBox(
            child: Image.asset(
              controller.bgImagePath.value,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: kToolbarHeight *2.4,),
                Text(
                  'Generate Project\nIdeas',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(16),
                Text(
                  'Generate project ideas base on field and \ndifficulty level',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gap(36),
                Center(
                  child: Column(
                    children: [
                      CustomDropdownField(
                        hint: 'Field',
                        items: fields,
                        value: selectedField.value,
                        onChanged: (val) => selectedField.value = val,
                        itemBuilder: (item) => Text(
                          item,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      // Gap(20),
                      // CustomDropdownField(
                      //   hint: 'Difficulty',
                      //   items: difficulties,
                      //   value: selectedDifficulty.value,
                      //   onChanged: (val) => selectedDifficulty.value = val,
                      //   itemBuilder: (item) => Text(
                      //     item,
                      //     style: TextStyle(
                      //       color: isDarkMode ? Colors.white : Colors.black,
                      //     ),
                      //   ),
                      // ),
                      Gap(32),
                      Obx(() => SizedBox(
                        // width: double.infinity,
                        width: 320,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: const Color(0xFFD7680D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: () async {
                            if (selectedField.value == null) {
                              Get.snackbar('Error', 'Field harus dipilih', snackPosition: SnackPosition.BOTTOM);
                              return;
                            }

                            await controller.generateJudul(selectedField.value!);

                            final resultController = Get.put(GenerateResultController());
                            resultController.setJudul(controller.judulList);

                            Get.toNamed(Routes.GENERATE_RESULT);
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
                            'Generate',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ))
                    ],
                  )
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
