import 'package:flutter/material.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:get/get.dart';

class UserStudentSwitcher extends StatelessWidget {
  final RxBool isUserTab;
  final Function(bool) onToggle;
  final double width;

  const UserStudentSwitcher({
    super.key,
    required this.isUserTab,
    required this.onToggle,
    this.width = 300,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Obx(() {
      return Container(
        width: width,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: isDarkMode ? ThemeApp.grayscaleAltMedium  : Colors.grey[300],
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment:
              isUserTab.value ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  width: width * 0.45,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: isDarkMode
                        ? ThemeApp.grayscaleMedium
                        : ThemeApp.grayscaleAltLight,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => onToggle(true),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Student',
                        style: TextStyle(
                          // fontWeight: FontWeight.w500,
                          fontWeight: isUserTab.value
                              ? FontWeight.w500
                              : FontWeight.w400,
                          fontSize: 14,
                          color: isUserTab.value
                              ? (isDarkMode ? Colors.white : Colors.black)
                              : (isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onToggle(false),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'User',
                        style: TextStyle(
                          fontWeight: isUserTab.value
                              ? FontWeight.w400
                              : FontWeight.w500,
                          fontSize: 14,
                          color: isUserTab.value
                              ? (isDarkMode ? Colors.grey[400] : Colors.grey[600])
                              : (isDarkMode ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
