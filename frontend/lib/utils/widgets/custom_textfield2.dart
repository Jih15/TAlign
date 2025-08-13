import 'package:flutter/material.dart';
import 'package:frontend/utils/theme_app.dart';
import 'package:get/get.dart';

class CustomTextField2 extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorMessage;
  final RegExp? validationPattern;
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

  final int? minLines;
  final int? maxLines;

  const CustomTextField2({
    super.key,
    this.maxLines,
    this.minLines,
    required this.controller,
    required this.hintText,
    this.errorMessage,
    this.validationPattern,
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
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validateInput);
  }

  void _validateInput() {
    final text = widget.controller.text;
    if (widget.validationPattern != null) {
      setState(() {
        hasError = widget.validationPattern!.hasMatch(text);
      });
    } else {
      setState(() {
        hasError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final defaultFillColor = isDarkMode ? ThemeApp.grayscaleMedium : const Color(0xFFF5F5F5);
    final activeBorderColor = hasError
        ? Colors.red
        : (widget.activeBorderColorOverride ?? (isDarkMode ? Colors.white70 : const Color(0xFFD7680D)));
    final enabledBorderColor = hasError
        ? Colors.red
        : (widget.defaultBorderColorOverride ?? (isDarkMode ? Colors.transparent : Colors.grey.shade300));
    final inputTextColor = widget.inputTextColorOverride ?? (isDarkMode ? Colors.white : Colors.black);
    final hintTextColor = widget.hintTextColorOverride ?? (isDarkMode ? Colors.white60 : Colors.grey[700]);
    final cursorColor = widget.cursorColorOverride ?? inputTextColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: TextFormField(
            controller: widget.controller,
            enabled: widget.enabled,
            obscureText: widget.isPassword && !(widget.isPasswordVisible?.value ?? false),
            keyboardType: widget.keyboardType,
            cursorColor: cursorColor,
            style: widget.textStyle ?? TextStyle(fontSize: 14, color: widget.enabled ? inputTextColor : Colors.grey),
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.fillColorOverride ?? defaultFillColor,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ?? TextStyle(fontSize: 14, color: hintTextColor),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0), // 🔹 Auto fit height
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: enabledBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: enabledBorderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: activeBorderColor, width: 1.5),
              ),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Text(
              widget.errorMessage ?? "Input tidak sesuai",
              style: TextStyle(
                fontSize: 12,
                color: Colors.red.shade700,
              ),
            ),
          ),
      ],
    );
  }
}
