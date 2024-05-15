import 'package:flutter/material.dart';
import 'package:lpr/components/tools/tools.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: MyColors.vert,
    scaffoldBackgroundColor: MyColors.beige,
    appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.beige,
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: MyColors.vert),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.bleu,
          foregroundColor: MyColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'comat',
          color: MyColors.bleunuit),
      titleLarge: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'comat',
          color: MyColors.bleunuit),
      labelLarge: TextStyle(
          fontSize: 18.0,
          letterSpacing: 1.8,
          fontWeight: FontWeight.normal,
          fontFamily: 'comat',
          color: MyColors.bleunuit),
      bodyLarge: TextStyle(
          fontSize: 16, fontFamily: 'comat', color: MyColors.bleunuit),
      bodyMedium: TextStyle(
          fontSize: 14, fontFamily: 'comat', color: MyColors.bleunuit),
      bodySmall: TextStyle(
          fontSize: 12, fontFamily: 'comat', color: MyColors.bleunuit),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: MyColors.bleu,
    scaffoldBackgroundColor: MyColors.bleunuit,
    colorScheme: ColorScheme.fromSeed(seedColor: MyColors.vert),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.vert,
          foregroundColor: MyColors.beige,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
    ),
    shadowColor: MyColors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'comat',
          color: MyColors.white),
      labelLarge: TextStyle(
          fontSize: 18.0,
          letterSpacing: 1.8,
          fontWeight: FontWeight.normal,
          fontFamily: 'comat',
          color: MyColors.white),
      bodyLarge:
          TextStyle(fontSize: 25, fontFamily: 'comat', color: MyColors.white),
      bodyMedium:
          TextStyle(fontSize: 20, fontFamily: 'comat', color: MyColors.white),
      bodySmall:
          TextStyle(fontSize: 18, fontFamily: 'comat', color: MyColors.white),
      labelSmall: TextStyle(
          fontSize: 16,
          letterSpacing: 4,
          fontFamily: 'comat',
          color: MyColors.beige),
    ),
  );
}
