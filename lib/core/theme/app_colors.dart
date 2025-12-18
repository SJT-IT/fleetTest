import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(
    0xFFA5C629,
  ); // Previously primaryVariant, now main primary
  static const Color primaryVariant = Color(
    0xFF296AB6,
  ); // Previously secondaryVariant
  static const Color secondary = Color(0xFF29B65D); // Bluish-green
  static const Color secondaryVariant = Color(
    0xFF296AB6,
  ); // Deep blue for accent (optional, you can keep or change)

  // Complementary / accent
  static const Color accent = Color(0xFF7AB629); // Vibrant green, moved here
  static const Color accentVariant = Color(
    0xFFB62973,
  ); // Magenta/pink (optional)

  // Surface & background
  static const Color surface = Colors.white;
  static const Color background = Color(0xFFE5F4D1); // Light green tint
  static const Color surfaceVariant = Color(0xFFF6F6F6); // Light neutral

  // Text colors
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.white;
  static const Color onSurface = Color(0xFF333333); // Dark neutral
  static const Color onBackground = Color(0xFF333333);

  // Dark mode
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkBackground = Color(0xFF000000);
  static const Color onDarkSurface = Colors.white;
  static const Color onDarkBackground = Colors.white;
}
