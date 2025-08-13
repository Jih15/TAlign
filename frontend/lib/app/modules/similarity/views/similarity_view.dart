import 'package:flutter/material.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:frontend/utils/widgets/background_wrapper.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/similarity_controller.dart';

class SimilarityView extends GetView<SimilarityController> {
  const SimilarityView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final _formKey = GlobalKey<FormState>();

    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Similarity Check'),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Get.offNamed(Routes.HOME);
            },
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kToolbarHeight *0.2),
              const Text(
                'Similarity Check',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
              ),
              const Gap(16),
              const Text(
                'Check your idea similarity to continue the project',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const Gap(36),

              // Form input
              Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.projectTitle,
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 5,
                        cursorColor:
                        isDarkMode ? Colors.white : Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Enter your project title',
                          filled: true,
                          fillColor: isDarkMode
                              ? ThemeApp.grayscaleMedium
                              : const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDarkMode
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                              color: Colors.black, // border hitam
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              width: 1.5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color:
                          isDarkMode ? Colors.white : Colors.black,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Judul tidak boleh kosong";
                          }
                          final wordCount = value
                              .trim()
                              .split(RegExp(r'\s+'))
                              .length;
                          if (wordCount < 5) {
                            return "Masukkan judul minimal 5 kata";
                          }
                          return null;
                        },
                      ),
                      const Gap(32),
                      Obx(
                            () => SizedBox(
                          width: 320,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding:
                              const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor:
                              isDarkMode ? Colors.white : Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: controller.isLoading.value
                                ? null
                                : () async {
                              if (_formKey.currentState!.validate()) {
                                await controller.onCheckSimilarity();
                              }
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
                                : Text(
                              'Check',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Gap(20),

              // Hasil similarity
              Expanded(
                child: Obx(() {
                  final response =
                      controller.dataController.similarityResponse.value;

                  if (response == null) {
                    return const SizedBox();
                  }

                  // Tidak ada kemiripan
                  if (response.matches.isEmpty) {
                    Future.microtask(() {
                      Get.defaultDialog(
                        title: "",
                        titlePadding: EdgeInsets.zero,
                        contentPadding: const EdgeInsets.all(20),
                        radius: 16,
                        backgroundColor: isDarkMode
                            ? ThemeApp.grayscaleMedium
                            : Colors.white,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Judul anda tidak memiliki kemiripan dengan penelitian sebelumnya.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const Gap(8),
                            Text(
                              "Similarity Score: ${response.similarityScore.toStringAsFixed(2)}%",
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode
                                    ? Colors.white70
                                    : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Lottie.asset(
                                ConstantAssets.lottieCheck,
                                repeat: true,
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                  Get.offNamed(
                                    Routes.SUBMIT_PROJECT,
                                    arguments: {
                                      'title':
                                      controller.projectTitle.text
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  backgroundColor: ThemeApp.greenSoft,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Lanjutkan ke Submission",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });

                    return const SizedBox();
                  }

                  return Container(
                    padding: EdgeInsets.all(12),
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.all(Radius.circular(24))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Similarity Judul Anda: ${response.similarityScore.toStringAsFixed(2)}%",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: response.similarityScore >= 70
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        Gap(8),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: response.matches.length,
                            itemBuilder: (context, index) {
                              final match = response.matches[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  title: Text(match.judulDataset),
                                  titleTextStyle: TextStyle(
                                    fontSize: 16,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  subtitle: Text(
                                    'Similarity: ${match.similarity.toStringAsFixed(1)}%',
                                    style: TextStyle(
                                      color: ThemeApp.grayscaleAltDark,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
