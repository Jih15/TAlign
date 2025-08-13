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
  final RxString? errorText;

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
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = forceLightMode
        ? false
        : Theme.of(context).brightness == Brightness.dark;

    final fillColor =
    isDarkMode ? Colors.grey[800]! : const Color(0xFFF5F5F5);
    final activeBorderColor =
    isDarkMode ? Colors.white70 : const Color(0xFFD7680D);
    final defaultBorderColor =
    isDarkMode ? Colors.white30 : Colors.grey.shade300;
    final errorBorderColor = Colors.red;
    final inputTextColor = isDarkMode ? Colors.white : Colors.black;
    final hintTextColor = isDarkMode ? Colors.grey[400]! : Colors.black54;
    final iconColor = isDarkMode ? Colors.white70 : Colors.black54;

    InputDecoration buildDecoration({bool hasError = false}) {
      return InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: hintStyle ?? TextStyle(fontSize: 14, color: hintTextColor),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
          BorderSide(color: hasError ? errorBorderColor : defaultBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
          BorderSide(color: hasError ? errorBorderColor : defaultBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: hasError ? errorBorderColor : activeBorderColor, width: 1.5),
        ),
        errorText: hasError && errorText != null ? errorText!.value : null,
        suffixIcon: isPassword && isPasswordVisible != null
            ? IconButton(
          icon: Icon(
            isPasswordVisible!.value
                ? Icons.visibility
                : Icons.visibility_off,
            color: iconColor,
          ),
          onPressed: () => isPasswordVisible!.toggle(),
        )
            : null,
      );
    }

    Widget buildField({bool hasError = false}) {
      return TextFormField(
        controller: controller,
        obscureText: isPassword && isPasswordVisible != null
            ? !isPasswordVisible!.value
            : false,
        keyboardType: keyboardType,
        cursorColor: inputTextColor,
        style: textStyle ?? TextStyle(fontSize: 14, color: inputTextColor),
        decoration: buildDecoration(hasError: hasError),
        onChanged: (_) {
          if (errorText != null && errorText!.value.isNotEmpty) {
            errorText!.value = ''; // hapus error saat user ketik ulang
          }
        },
      );
    }

    // Kalau ada errorText (RxString) → pakai Obx
    if (errorText != null) {
      return Obx(() {
        final hasError = errorText!.value.isNotEmpty;
        return buildField(hasError: hasError);
      });
    }

    // Kalau tidak ada errorText tapi ada isPasswordVisible (RxBool) → tetap pakai Obx
    if (isPassword && isPasswordVisible != null) {
      return Obx(() => buildField());
    }

    // Kalau tidak ada observable sama sekali
    return buildField();
  }
}
