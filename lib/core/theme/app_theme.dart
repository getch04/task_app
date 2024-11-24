import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    primaryColor: const Color(0xFF4525A2),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    // Add more theme configurations
  );
} 