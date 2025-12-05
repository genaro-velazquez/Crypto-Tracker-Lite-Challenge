
import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const Color primaryBackground = Color(0xFF0F0F0F);
  static const Color secondaryBackground = Color(0xFF1A1A1A);
  static const Color surfaceColor = Color(0xFF2D2D2D);
  static const Color borderColor = Color(0xFF3F3F3F);

  // Accents
  static const Color primary = Color(0xFF1E88E5);
  static const Color gold = Color(0xFFFFDD00);

  // States
  static const Color positive = Color(0xFF4CAF50);
  static const Color negative = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFF9800);

  // Text
  static const Color textPrimary = Color(0xFFFAFAFA);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF757575);

  // Helper
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }
}