import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFFFFFFFF); // White for light mode
  static const Color primaryVariant = Color(0xFF000000); // Black for dark mode
  static const Color secondary = Color(0xFF7AB629); // Minimal green accent
  static const Color secondaryVariant = Color(
    0xFF7AB629,
  ); // Same green for consistency

  // Complementary / accent
  static const Color accent = Color(0xFF7AB629); // Green accent
  static const Color accentVariant = Color(
    0xFF7AB629,
  ); // Same green accent variant

  // Surface & background
  static const Color surface = Colors.white; // Light surface for light mode
  static const Color background = Color(
    0xFFF5F5F5,
  ); // Light grey background for light mode
  static const Color surfaceVariant = Color(
    0xFFF5F5F5,
  ); // Same as background for simplicity

  // Text colors
  static const Color onPrimary = Color(
    0xFF333333,
  ); // Dark text on white for light mode
  static const Color onSecondary = Colors.white; // Light text on green accent
  static const Color onSurface = Color(
    0xFF333333,
  ); // Dark text on light surfaces
  static const Color onBackground = Color(
    0xFF333333,
  ); // Dark text on light background

  // Dark mode
  static const Color darkSurface = Color(
    0xFF121212,
  ); // Dark surface for dark mode
  static const Color darkBackground = Color(
    0xFF000000,
  ); // Black background for dark mode
  static const Color onDarkSurface = Colors.white; // Light text on dark surface
  static const Color onDarkBackground =
      Colors.white; // Light text on dark background
}
