import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF4525A2);
  static const Color background = Colors.white;
  static const Color surface = Colors.white;
  static const Color error = Colors.red;
  static const Color warning = Colors.amber;

  // Text colors
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Colors.white;

  // Border and divider colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFE0E0E0);

  // Status colors
  static const Color success = Colors.green;
  static const Color pending = Colors.amber;

  // Component specific colors
  static const Color cardBackground = Colors.white;
  static const Color iconBackground = Color(0xFFEFECF8);
  static const Color checkboxActive = primary;
  static const Color buttonPrimary = primary;

  static ThemeData get light => ThemeData(
        fontFamily: 'CabinetGrotesk',
        primaryColor: primary,
        scaffoldBackgroundColor: background,

        // Component themes
        appBarTheme: const AppBarTheme(
          backgroundColor: background,
          elevation: 0,
        ),

        cardTheme: CardTheme(
          color: cardBackground,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primary),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),

        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primary;
            }
            return null;
          }),
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: primary,
          unselectedItemColor: textSecondary,
        ),
      );
}
