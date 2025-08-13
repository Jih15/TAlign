import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/theme_app.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String hint;
  final List<T> items;
  final T? value;
  final void Function(T?) onChanged;
  final Widget Function(T) itemBuilder;

  // Tambahan parameter opsional untuk customisasi warna
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? dropdownBackgroundColor;
  final Color? overlayColor;
  final Color? iconColor;

  const CustomDropdownField({
    super.key,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemBuilder,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.textColor,
    this.hintTextColor,
    this.dropdownBackgroundColor,
    this.overlayColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Default values berdasarkan mode tema
    final Color defaultFillColor =
    isDarkMode ? ThemeApp.grayscaleMedium : ThemeApp.grayscaleAltLight;
    final Color defaultBorderColor =
    isDarkMode ? Colors.transparent : Colors.grey.shade300;
    final Color defaultFocusedBorderColor =
    isDarkMode ? Colors.white70 : const Color(0xFFD7680D);
    final Color defaultTextColor = isDarkMode ? Colors.white : Colors.black;
    final Color defaultHintTextColor =
    isDarkMode ? Colors.white60 : Colors.grey[700]!;
    final Color defaultDropdownBgColor =
    isDarkMode ? Colors.grey[850]! : Colors.white;
    final Color defaultOverlayColor =
    isDarkMode ? Colors.white10 : Colors.black12;
    final Color defaultIconColor = isDarkMode ? Colors.white : Colors.black;

    return DropdownButtonFormField2<T>(
      value: value,
      isExpanded: true,
      onChanged: onChanged,

      /// Dropdown Items
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: DefaultTextStyle(
            style: TextStyle(
              color: textColor ?? defaultTextColor,
              fontSize: 14,
            ),
            child: itemBuilder(item),
          ),
        );
      }).toList(),

      /// Hint
      hint: Text(
        hint,
        style: TextStyle(
          fontSize: 14,
          color: hintTextColor ?? defaultHintTextColor,
        ),
      ),

      /// Button style (field)
      buttonStyleData: ButtonStyleData(
        height: 48,
        padding: const EdgeInsets.only(left: 0, right: 16),
        decoration: BoxDecoration(
          color: fillColor ?? defaultFillColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor ?? defaultBorderColor,
          ),
        ),
        elevation: 0,
      ),

      /// Icon style
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: iconColor ?? defaultIconColor,
        ),
        iconSize: 28,
      ),

      /// Dropdown popup style
      dropdownStyleData: DropdownStyleData(
        maxHeight: 150,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: dropdownBackgroundColor ?? defaultDropdownBgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        elevation: 4,
        offset: const Offset(0, 4),
      ),

      /// Menu item style
      menuItemStyleData: MenuItemStyleData(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        overlayColor: WidgetStatePropertyAll(
          overlayColor ?? defaultOverlayColor,
        ),
      ),

      /// Form decoration (border, validation)
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: borderColor ?? defaultBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: focusedBorderColor ?? defaultFocusedBorderColor,
            width: 1.5,
          ),
        ),
      ),

      /// Text style (selected item)
      style: TextStyle(
        color: textColor ?? defaultTextColor,
        fontSize: 14,
      ),
    );
  }
}
