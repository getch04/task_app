import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        fontFamily: 'CabinetGrotesk',
        primaryColor: const Color(0xFF4525A2),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      );
}
