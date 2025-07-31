import 'package:flutter/material.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:gap/gap.dart';

class ProfileCard extends StatelessWidget {
  final String fullName;
  final String nim;
  final String majors;
  final String studyProgram;

  const ProfileCard({
    super.key,
    required this.fullName,
    required this.nim,
    required this.majors,
    required this.studyProgram,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 3,
      decoration: BoxDecoration(
        color: isDarkMode
            ? ThemeApp.grayscaleMedium
            : ThemeApp.grayscaleAltLight,
        borderRadius: BorderRadius.circular(16),
        border: isDarkMode
            ? null
            : Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(500)
              ),
              child: Image.asset(ConstantAssets.imgProfile),
            ),
            const Gap(20),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(4),
                Text(
                  nim,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Gap(4),
                Text(
                  majors,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Gap(4),
                Text(
                  studyProgram,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
