import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeLight = ThemeData.light().copyWith(
  colorScheme: const ColorScheme.light().copyWith(
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.grey,
    onSurface: const Color(0xff363636),
    onPrimary: const Color(0xff8875FF),
  ),
  textTheme: TextTheme(
    labelMedium: GoogleFonts.lato().copyWith(
      fontSize: 32,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: GoogleFonts.lato().copyWith(
      fontSize: 40,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: GoogleFonts.lato().copyWith(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: GoogleFonts.lato().copyWith(
      fontSize: 22,
      color: Colors.black,
    ),
    bodyMedium: GoogleFonts.lato().copyWith(
      fontSize: 16,
      color: Colors.black,
    ),
    bodySmall: GoogleFonts.lato().copyWith(
      fontSize: 12,
      color: Colors.black,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff8875FF),
      foregroundColor: Colors.black,
      textStyle: const TextStyle(
        color: Colors.black,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      elevation: 0,
    ),
  ),
);

final themeDark = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark().copyWith(
    background: Colors.black,
    onBackground: Colors.white,
    surface: const Color(0xff363636),
    onSurface: const Color(0xffAFAFAF),
    onPrimary: const Color(0xff8875FF),
  ),
  textTheme: TextTheme(
    labelMedium: GoogleFonts.lato().copyWith(
      fontSize: 32,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: GoogleFonts.lato().copyWith(
      fontSize: 40,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: GoogleFonts.lato().copyWith(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: GoogleFonts.lato().copyWith(
      fontSize: 22,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.lato().copyWith(
      fontSize: 16,
      color: Colors.white,
    ),
    bodySmall: GoogleFonts.lato().copyWith(
      fontSize: 12,
      color: Colors.white,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff8875FF),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      elevation: 0,
    ),
  ),
);
