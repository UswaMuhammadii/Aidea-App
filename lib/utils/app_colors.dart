// app_colors.dart - Consistent theme colors for entire app

import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Electric Blue as main theme
  static const electricBlue = Color(0xFF3B82F6); // Main primary color
  static const deepPurple = Color(0xFF7C3AED); // Accent color
  static const brightTeal = Color(0xFF14B8A6);

  // Gradient Definitions
  static const primaryGradient = LinearGradient(
    colors: [electricBlue, brightTeal], // Blue to Teal
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const accentGradient = LinearGradient(
    colors: [electricBlue, brightTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const buttonGradient = LinearGradient(
    colors: [electricBlue, brightTeal],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Dashboard Specific Gradients
  static const headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF3B82F6), // Electric Blue
      Color(0xFF0EA5E9), // Sky Blue
      Color(0xFF14B8A6), // Teal
    ],
  );

  static const drawerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF3B82F6),
      Color(0xFF60A5FA),
      Color(0xFF93C5FD),
    ],
  );

  // Status Colors
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = electricBlue;
}
