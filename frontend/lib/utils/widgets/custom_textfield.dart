import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final RxBool? isPasswordVisible;
  final TextInputType keyboardType;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool forceLightMode;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.isPasswordVisible,
    this.keyboardType = TextInputType.text,
    this.textStyle,
    this.hintStyle,
    this.forceLightMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = forceLightMode
        ? false
        : Theme.of(context).brightness == Brightness.dark;

    final fillColor = isDarkMode ? Colors.grey[800]! : const Color(0xFFF5F5F5);
    final activeBorderColor = isDarkMode ? Colors.white70 : const Color(0xFFD7680D);
    final defaultBorderColor = isDarkMode ? Colors.white30 : Colors.grey.shade300;
    final inputTextColor = isDarkMode ? Colors.white : Colors.black;
    final hintTextColor = isDarkMode ? Colors.grey[400]! : Colors.black54;
    final iconColor = isDarkMode ? Colors.white70 : Colors.black54;

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: fillColor,
      hintText: hintText,
      hintStyle: hintStyle ?? TextStyle(fontSize: 14, color: hintTextColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: defaultBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: activeBorderColor, width: 1.5),
      ),
    );

    if (isPassword && isPasswordVisible != null) {
      return Obx(() => TextFormField(
        controller: controller,
        obscureText: !isPasswordVisible!.value,
        keyboardType: keyboardType,
        cursorColor: inputTextColor,
        style: textStyle ?? TextStyle(fontSize: 14,color: inputTextColor),
        decoration: inputDecoration.copyWith(
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible!.value
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: iconColor,
            ),
            onPressed: () => isPasswordVisible!.toggle(),
          ),
        ),
      ));
    }

    return TextFormField(
      controller: controller,
      obscureText: false,
      keyboardType: keyboardType,
      cursorColor: inputTextColor,
      style: textStyle ?? TextStyle(fontSize: 14,color: inputTextColor),
      decoration: inputDecoration,
    );
  }
}
