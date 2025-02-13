import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: MyColors.success,
    scaffoldBackgroundColor: MyColors.secondary,
    appBarTheme: const AppBarTheme(
        backgroundColor: MyColors.primary, foregroundColor: MyColors.secondary),
    colorScheme: ColorScheme.fromSeed(seedColor: MyColors.success),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.textprimary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: MyColors.textprimary,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'comat',
          color: MyColors.textprimary),
      titleLarge: TextStyle(
          fontSize: 25.0, fontFamily: 'comat', color: MyColors.textprimary),
      titleMedium: TextStyle(
          fontSize: 23.0, fontFamily: 'comat', color: MyColors.textprimary),
      titleSmall: TextStyle(
          fontSize: 20.0, fontFamily: 'comat', color: MyColors.textprimary),
      labelLarge: TextStyle(
          fontSize: 18.0,
          letterSpacing: 1.8,
          fontWeight: FontWeight.normal,
          fontFamily: 'comat',
          color: MyColors.textprimary),
      bodyLarge: TextStyle(
          fontSize: 16, fontFamily: 'comat', color: MyColors.textprimary),
      bodyMedium: TextStyle(
          fontSize: 14, fontFamily: 'comat', color: MyColors.textprimary),
      bodySmall: TextStyle(
          fontSize: 12, fontFamily: 'comat', color: MyColors.textprimary),
      labelSmall: TextStyle(
          fontSize: 12, fontFamily: 'comat', color: MyColors.textprimary),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: MyColors.textprimary,
    scaffoldBackgroundColor: MyColors.textprimary,
    colorScheme: ColorScheme.fromSeed(seedColor: MyColors.success),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.success,
          foregroundColor: MyColors.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
    ),
    shadowColor: Colors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'comat',
          color: Colors.white),
      labelLarge: TextStyle(
          fontSize: 18.0,
          letterSpacing: 1.8,
          fontWeight: FontWeight.normal,
          fontFamily: 'comat',
          color: Colors.white),
      bodyLarge:
          TextStyle(fontSize: 25, fontFamily: 'comat', color: Colors.white),
      bodyMedium:
          TextStyle(fontSize: 20, fontFamily: 'comat', color: Colors.white),
      bodySmall:
          TextStyle(fontSize: 18, fontFamily: 'comat', color: Colors.white),
      labelSmall: TextStyle(
          fontSize: 16,
          letterSpacing: 4,
          fontFamily: 'comat',
          color: MyColors.secondary),
    ),
  );
}
