import 'package:Cek_Tugas_Akhir/utils/constant_assets.dart';
import 'package:Cek_Tugas_Akhir/utils/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width/3,
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
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ConstantAssets.imgProfile,
            ),
            Gap(20),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zaqaul Fikri Aziz (Jih)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '2111082049',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'D4-Teknologi Rekayasa Perangkat Lunak',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'TRPL-4A',
                  style: TextStyle(
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