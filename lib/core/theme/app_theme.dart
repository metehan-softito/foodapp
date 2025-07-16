// app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData cartoon = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Segoe UI',
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
    useMaterial3: true,
  );

  static ThemeData realistic = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Segoe UI',
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
    useMaterial3: true,
  );
}
