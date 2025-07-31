import 'package:flutter/material.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:frontend/utils/widgets/background_wrapper.dart';
import 'package:frontend/utils/widgets/custom_textfield2.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/similarity_controller.dart';

class SimilarityView extends GetView<SimilarityController> {
  const SimilarityView({super.key});
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Similarity Check'),
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
        body: Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kToolbarHeight,),
              Text(
                'Similarity Check',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(16),
              Text(
                'Check your idea simmilarity to continue the project ',
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
                      CustomTextField2(
                        controller: controller.projectTitle,
                        hintText: 'Project title idea',
                      ),
                      Gap(20),
                      //
                      Gap(56),
                      Obx(() => SizedBox(
                        // width: double.infinity,
                        width: 360,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: const Color(0xFFFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: () async {},

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
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ))
                    ],
                  )
              )
            ],
          ),
        )
      ),
    );
  }
}
