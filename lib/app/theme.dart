import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _primaryPurple = Colors.purple;
  static const Color _secondaryGreen = Color(0xFF4ADE80);

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.purple,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryPurple,
        brightness: Brightness.light,
        surface: Colors.white,
        onSurface: Colors.black,
        primary: _primaryPurple,
        onPrimary: Colors.white,
        secondary: _secondaryGreen,
        onSecondary:
            Colors.black, // Dark text on light green for better contrast
        tertiary: Colors.blue,
        error: Colors.red,
        onError: Colors.white,
      ),
      textTheme: _buildTextTheme(Colors.black),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.purple,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF121212),
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryPurple,
        brightness: Brightness.dark,
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white,
        primary:
            _primaryPurple, // Could be a lighter shade like Colors.purpleAccent
        onPrimary: Colors.white,
        secondary: _secondaryGreen,
        onSecondary: Colors.black,
        tertiary: Colors.blueAccent,
        error: Colors.redAccent,
        onError: Colors.black,
      ),
      textTheme: _buildTextTheme(Colors.white),
    );
  }

  static TextTheme _buildTextTheme(Color baseColor) {
    return TextTheme(
      displayLarge: GoogleFonts.lato(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: baseColor,
      ),
      displayMedium: GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: baseColor,
      ),
      titleLarge: GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: baseColor,
      ),
      titleMedium: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: baseColor,
      ),
      bodyLarge: GoogleFonts.lato(
        fontSize: 16,
        color: baseColor,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: 14,
        color: baseColor,
      ),
    );
  }
}
