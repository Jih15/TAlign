import 'package:flutter/material.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:frontend/utils/constant_assets.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double iconSize = height * 0.06;
    double profileSize = height * 0.05;
    // double containerHeight = height * 0.06;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: width,
      height: height * 0.12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// === Left: Model Badge ===
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerLeft,
            children: [
              // Model name
              Container(
                margin: EdgeInsets.only(left: iconSize / 6),
                padding: EdgeInsets.only(left: iconSize, right: height * 0.04),
                height: height * 0.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: isDarkMode
                      ? [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 1,
                            offset: Offset(2, 2),
                          ),
                        ]
                      : [],

                  border: isDarkMode
                      ? null
                      : Border.all(color: Colors.grey.shade400, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Gemini',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '2.5 Flash',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  ],
                ),
              ),

              // Model Icon
              Positioned(
                left: 0,
                child: Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: isDarkMode
                        ? [
                            const BoxShadow(
                              color: Colors.black26,
                              blurRadius: 1,
                              offset: Offset(2, 2),
                            ),
                          ]
                        : [],
                    border: isDarkMode
                        ? null
                        : Border.all(color: Colors.grey.shade400, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      ConstantAssets.icoGemini, // ← Ganti ini dengan ikonmu
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// === Right: Profile ===
          InkWell(
            onTap: () => Get.toNamed(
              Routes.PROFILE,
            ),
            child: Container(
            width: profileSize,
            height: profileSize,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipOval(
              child: Image.asset(
                ConstantAssets.imgProfile, // ← Ganti ini dengan foto profilmu
                fit: BoxFit.cover,
              ),
            ),
          ),
          )
        ],
      ),
    );
  }
}
