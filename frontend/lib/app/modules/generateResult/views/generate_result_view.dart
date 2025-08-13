import 'package:flutter/material.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controllers/generate_result_controller.dart';

class GenerateResultView extends GetView<GenerateResultController> {
  const GenerateResultView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.find<GenerateResultController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setBgImg(isDarkMode);
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Ideas Result'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(Routes.GENERATE);
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
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(24),
                  const Text(
                    'Idea Project\nResult',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                  const Text(
                    'Generate project ideas base on field and \ndifficulty level',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Gap(36),
                  // Ini bagian hasil yang bisa discroll
                  Expanded(
                    child: Obx(() {
                      if (controller.judulList.isEmpty) {
                        return const Center(
                          child: Text(
                            "No ideas generated.",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      return Skeletonizer(
                        enabled: controller.isLoading.value,
                        child: ListView.builder(
                          itemCount: controller.judulList.length,
                          itemBuilder: (context, index) {
                            final judul = controller.judulList[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  judul,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
