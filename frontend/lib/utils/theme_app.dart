import 'package:flutter/material.dart';


class ThemeApp {
  // Grayscale
  static const Color grayscaleDarker = Color(0xFF0E1619); // for cards in dark mode
  static const Color grayscaleDark = Color(0xFF050505); // almost black
  static const Color grayscaleMedium = Color(0xFF3A3B3F); // for icon backgrounds, etc.
  static const Color grayscaleAltDark = Color(0xFF959595); // Alt dark
  static const Color grayscaleLight = Color(0xFFDFDFDF); // light gray for surface in light mode
  static const Color grayscaleLighter = Color(0xFFE3E3E3); // placeholder/loading
  static const Color grayscaleLightest = Color.fromRGBO(245, 245, 245, 1); // background in light mode
  static const Color grayscaleFullLight = Color(0xFFFFFFFF); // pure white
  static const Color grayscaleAltLight = Color(0xFFF8F8F8); // alternative white

  // Branding colors
  static const Color green = Color(0xFF178D64); // for buttons/icons
  static const Color greenSoft = Color(0xFF40B98F); // lighter green
  static const Color orange = Color(0xFFE98834); // generate ideas button
  static const Color orangeDark = Color(0xFFD16608); // hover/pressed

  // Util color
  static const Color darkRed = Color(0xFF9C1818);

  /// LIGHT THEME
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: grayscaleLightest,
    primaryColor: green,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: grayscaleFullLight,
      onPrimary: Colors.black,
      secondary: green,
      onSecondary: Colors.white,
      surface: grayscaleLight,
      onSurface: Colors.black,
      error: darkRed,
      onError: Colors.white,
      onSecondaryFixedVariant: orange, // accent
      onTertiary: greenSoft,
      onTertiaryFixedVariant: green,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: grayscaleDark),
    ),
  );

  /// DARK THEME
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: grayscaleDark,
    primaryColor: green,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: grayscaleDark,
      onPrimary: Colors.white,
      secondary: green,
      onSecondary: Colors.white,
      surface: grayscaleDarker,
      onSurface: grayscaleLightest,
      error: darkRed,
      onError: Colors.black,
      onSecondaryFixedVariant: orange,
      onTertiary: greenSoft,
      onTertiaryFixedVariant: green,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: grayscaleLightest),
    ),
  );
}
