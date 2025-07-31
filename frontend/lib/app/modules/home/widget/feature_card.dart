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
        final double gap = 16;
        final double cardWidth = (totalWidth - gap) / 2;
        final double cardHeight = cardWidth * 1.88;

        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// === Kiri: Card Besar (Generate Project Ideas) ===
              InkWell(
                onTap: ()=> Get.toNamed(Routes.GENERATE),
                child: Container(
                  width: cardWidth,
                  height: cardHeight,
                  decoration: BoxDecoration(
                    color: color.onSecondaryFixedVariant,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ThemeApp.orangeDark,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          ConstantAssets.icoGenerateCard,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Generate \nProject Ideas',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: ThemeApp.grayscaleDark,
                            height: 1.0
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Let\'s try it now!',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ThemeApp.grayscaleDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: gap),

              /// === Kanan: Dua Card Kecil (Stacked Column) ===
              Column(
                children: [
                  Container(
                    width: cardWidth,
                    height: (cardHeight - gap) / 2,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.onSurface,
                      borderRadius: BorderRadius.circular(16),
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
                  SizedBox(height: gap),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.SUBMIT_PROJECT),
                    child: Container(
                      width: cardWidth,
                      height: (cardHeight - gap) / 2,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.onTertiary,
                        borderRadius: BorderRadius.circular(16),
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
