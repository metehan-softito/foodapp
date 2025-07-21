// app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData cartoon = ThemeData(
    dividerTheme: DividerThemeData(color: Colors.grey),
    dividerColor: Colors.grey,
    brightness: Brightness.light,
    fontFamily: 'Segoe UI',
    primaryColor: Color(0xFFFF7700),
    scaffoldBackgroundColor: const Color(0xFFFFFAF0),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFFF7700),
      secondary: Color(0xFFFBE9E7),
      surface: Color(0xFFFFFFFF),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black54,
    ),
  );

  static ThemeData realistic = ThemeData(
    dividerTheme: DividerThemeData(color: Colors.grey),

    dividerColor: Colors.grey,
    brightness: Brightness.dark,
    fontFamily: 'Segoe UI',
    primaryColor: const Color(0xFFBB86FC),
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFBB86FC),
      secondary: Color(0xFF2C2C2C),
      surface: Color(0xFF1F1F1F),
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.white70,
    ),
    useMaterial3: true,
  );
}
