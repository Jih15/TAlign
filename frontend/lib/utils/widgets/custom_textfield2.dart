import 'package:flutter/material.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:get/get.dart';

class CustomTextField2 extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final RxBool? isPasswordVisible;
  final TextInputType keyboardType;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  const CustomTextField2({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.isPasswordVisible,
    this.keyboardType = TextInputType.text,
    this.textStyle,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final fillColor = isDarkMode
        ? ThemeApp.grayscaleMedium
        : const Color(0xFFF5F5F5);
    final activeBorderColor = isDarkMode
        ? Colors.white70
        : const Color(0xFFD7680D);
    final defaultBorderColor = isDarkMode
        ? Colors.transparent
        : Colors.grey.shade300;
    final inputTextColor = isDarkMode ? Colors.white : Colors.black;
    final hintTextColor = isDarkMode ? Colors.white60 : Colors.grey[700];

    return TextFormField(
      controller: controller,
      obscureText: false,
      keyboardType: keyboardType,
      cursorColor: inputTextColor,
      style: textStyle ?? TextStyle(fontSize: 14, color: inputTextColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: hintStyle ?? TextStyle(fontSize: 14, color: hintTextColor),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      ),
    );
  }
}
