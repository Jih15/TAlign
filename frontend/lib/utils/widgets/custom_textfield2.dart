import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontend/utils/theme_app.dart';

class CustomTextField2 extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final RxBool? isPasswordVisible;
  final TextInputType keyboardType;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;

  final Color? fillColorOverride;
  final Color? activeBorderColorOverride;
  final Color? defaultBorderColorOverride;
  final Color? inputTextColorOverride;
  final Color? hintTextColorOverride;
  final Color? cursorColorOverride;

  final bool enabled;

  const CustomTextField2({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.isPasswordVisible,
    this.keyboardType = TextInputType.text,
    this.textStyle,
    this.hintStyle,
    this.fillColorOverride,
    this.activeBorderColorOverride,
    this.defaultBorderColorOverride,
    this.inputTextColorOverride,
    this.hintTextColorOverride,
    this.cursorColorOverride,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final defaultFillColor = isDarkMode ? ThemeApp.grayscaleMedium : const Color(0xFFF5F5F5);
    final defaultActiveBorderColor = isDarkMode ? Colors.white70 : const Color(0xFFD7680D);
    final defaultBorderColor = isDarkMode ? Colors.transparent : Colors.grey.shade300;
    final defaultInputTextColor = isDarkMode ? Colors.white : Colors.black;
    final defaultHintTextColor = isDarkMode ? Colors.white60 : Colors.grey[700];

    final fillColor = fillColorOverride ?? defaultFillColor;
    final activeBorderColor = activeBorderColorOverride ?? defaultActiveBorderColor;
    final enabledBorderColor = defaultBorderColorOverride ?? defaultBorderColor;
    final inputTextColor = inputTextColorOverride ?? defaultInputTextColor;
    final hintTextColor = hintTextColorOverride ?? defaultHintTextColor;
    final cursorColor = cursorColorOverride ?? inputTextColor;

    if (isPassword && isPasswordVisible != null) {
      return Obx(() {
        return _buildTextField(
          context,
          isDarkMode,
          fillColor,
          activeBorderColor,
          enabledBorderColor,
          inputTextColor,
          hintTextColor,
          cursorColor,
          !isPasswordVisible!.value,
        );
      });
    }

    return _buildTextField(
      context,
      isDarkMode,
      fillColor,
      activeBorderColor,
      enabledBorderColor,
      inputTextColor,
      hintTextColor,
      cursorColor,
      isPassword,
    );
  }

  Widget _buildTextField(
      BuildContext context,
      bool isDarkMode,
      Color fillColor,
      Color activeBorderColor,
      Color enabledBorderColor,
      Color inputTextColor,
      Color? hintTextColor,
      Color cursorColor,
      bool obscureText,
      ) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: cursorColor,
      style: textStyle ?? TextStyle(fontSize: 14, color: enabled ? inputTextColor : Colors.grey),
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: hintStyle ?? TextStyle(fontSize: 14, color: hintTextColor),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: isDarkMode ? Colors.transparent : Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: enabledBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: activeBorderColor, width: 1.5),
        ),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            (isPasswordVisible?.value ?? false) ? Icons.visibility : Icons.visibility_off,
            color: inputTextColor,
          ),
          onPressed: () {
            if (isPasswordVisible != null) {
              isPasswordVisible!.value = !isPasswordVisible!.value;
            }
          },
        )
            : null,
      ),
    );
  }
}
