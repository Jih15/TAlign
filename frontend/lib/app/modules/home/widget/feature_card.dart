import 'package:flutter/material.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:get/get.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        final double gap = 20;
        final double cardWidth = (totalWidth - gap) / 2;
        final double cardHeight = cardWidth * 1.88;

        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// === Kiri: Card Besar (Generate Project Ideas) ===
              InkWell(
                onTap: () => Get.toNamed(Routes.GENERATE),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: cardWidth,
                    height: cardHeight,
                    color: ThemeApp.orange,
                    child: Stack(
                      children: [
                        // Ripple paling besar
                        Positioned(
                          top: -36,
                          left: -36,
                          child: Container(
                            width: 144,
                            height: 144,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ThemeApp.orangeDark.withOpacity(0.2),
                            ),
                          ),
                        ),
                        // Ripple sedang
                        Positioned(
                          top: -12,
                          left: -12,
                          child: Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ThemeApp.orangeDark.withOpacity(0.4),
                            ),
                          ),
                        ),
                        // Ripple kecil + ikon
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ThemeApp.orangeDark.withOpacity(0.6),
                            ),
                            child: Center(
                              child: Image.asset(
                                ConstantAssets.icoGenerateCard,
                                width: 28,
                                height: 28,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        // Teks bawah
                        Positioned(
                          bottom: 12,
                          left: 12,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Generate\nProject Ideas',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Let’s try it now',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
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
              SizedBox(width: gap),
              /// === Kanan: Dua Card Kecil (Stacked Column) ===
              Column(
                children: [
                  InkWell(
                    onTap: () => Get.toNamed(Routes.SIMILARITY),
                    child: Container(
                      width: cardWidth,
                      height: (cardHeight - gap) / 2,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.onSurface,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? ThemeApp.grayscaleLighter
                                  : ThemeApp.grayscaleMedium,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              isDarkMode
                                  ? ConstantAssets.icoSimilarityDark
                                  : ConstantAssets.icoSimilarityLight,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Similarity\nCheck',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.surface,
                              height: 1.0
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: gap),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.SUBMIT_PROJECT),
                    child: Container(
                      width: cardWidth,
                      height: (cardHeight - gap) / 2,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.onTertiary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: color.onTertiaryFixedVariant,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              ConstantAssets.icoSubmitPr
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Submit\nProject Ideas',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              height: 1.0
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
