import 'package:Cek_Tugas_Akhir/utils/theme_app.dart';
import 'package:flutter/material.dart';

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

    return DropdownButtonFormField<T>(
      value: value,
      onChanged: onChanged,
      isExpanded: true,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: itemBuilder(item),
        );
      }).toList(),
      decoration: InputDecoration(
        filled: true,
        fillColor: isDarkMode
          ? ThemeApp.grayscaleMedium
          : ThemeApp.grayscaleAltLight,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12, color: Colors.white),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
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
              : const BorderSide(color: ThemeApp.grayscaleLight, width: 1.5),
        ),
      ),
      dropdownColor: Colors.grey[900],
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: isDarkMode
        ? Colors.white : Colors.black,
      ),
      iconSize: 28,
      borderRadius: BorderRadius.circular(16),
      style: const TextStyle(color: Colors.white, fontSize: 16),
      menuMaxHeight: 300,
    );
  }
}
