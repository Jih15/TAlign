import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/theme_app.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String hint;
  final List<T> items;
  final T? value;
  final void Function(T?) onChanged;
  final Widget Function(T) itemBuilder;

  const CustomDropdownField({
    super.key,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
              color: isDarkMode ? Colors.white : Colors.black,
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
          color: isDarkMode ? Colors.white60 : Colors.grey[700],
        ),
      ),

      /// Button style (field)
      buttonStyleData: ButtonStyleData(
        height: 48,
        padding: const EdgeInsets.only(left: 0, right: 16),
        decoration: BoxDecoration(
          color: isDarkMode
              ? ThemeApp.grayscaleMedium
              : ThemeApp.grayscaleAltLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDarkMode
                ? Colors.transparent
                : Colors.grey.shade300,
          )
        ),
        elevation: 0,
      ),

      /// Icon style
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        iconSize: 28,
      ),

      /// Dropdown popup style
      dropdownStyleData: DropdownStyleData(
        maxHeight: 150,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, 4),
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
          isDarkMode ? Colors.white10 : Colors.black12,
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
            color: isDarkMode
                ? Colors.white30
                : Colors.grey.shade300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode
                ? Colors.white70
                : const Color(0xFFD7680D),
            width: 1.5,
          ),
        ),
      ),

      /// Text style (selected item)
      style: TextStyle(
        color: isDarkMode
            ? Colors.white
            : Colors.black,
        fontSize: 14,
      ),
    );
  }
}
