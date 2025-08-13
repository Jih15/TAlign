import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ConfirmDialogContent extends StatelessWidget {
  final String title;
  final String description;
  final String cancelText;
  final String confirmText;
  final Color? cancelColor;
  final Color? confirmTextColor;

  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  const ConfirmDialogContent({
    super.key,
    required this.title,
    required this.description,
    this.cancelText = 'Cancel',
    this.confirmText = 'Confirm',
    this.cancelColor,
    this.confirmTextColor,
    this.onCancel,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF111617) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const Gap(12),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          const Gap(32),
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmallWidth = constraints.maxWidth < 380;
              return isSmallWidth
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: onConfirm ?? () => Get.back(result: true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cancelColor ?? const Color(0xFF4B8673),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16,
                      ),
                    ),
                    child: FittedBox(
                      child: Text(
                        cancelText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Gap(12),
                  TextButton(
                    onPressed: onCancel ?? () => Get.back(result: false),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                    child: FittedBox(
                      child: Text(
                        confirmText,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: confirmTextColor ?? Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onConfirm ?? () => Get.back(result: true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cancelColor ?? const Color(0xFF4B8673),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16,
                        ),
                      ),
                      child: FittedBox(
                        child: Text(
                          cancelText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: TextButton(
                      onPressed: onCancel ?? () => Get.back(result: false),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                      child: FittedBox(
                        child: Text(
                          confirmText,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: confirmTextColor ?? Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
