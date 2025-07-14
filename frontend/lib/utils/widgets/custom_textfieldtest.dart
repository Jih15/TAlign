import 'package:flutter/material.dart';
import 'package:frontend/utils/theme_app.dart';

class CustomTextfieldtest extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const CustomTextfieldtest({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(255, 158, 158, 158),
        ),
        prefixIcon: prefixIcon,
        filled: true,
        suffixIcon: suffixIcon,
        fillColor: isDarkMode
            ? ThemeApp.grayscaleMedium
            : ThemeApp.grayscaleFullLight,

        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16.0),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: isDarkMode
              ? BorderSide.none
              : const BorderSide(color: ThemeApp.grayscaleLight, width: 1.0),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: isDarkMode
              ? BorderSide.none
              : const BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    );
  }
}
