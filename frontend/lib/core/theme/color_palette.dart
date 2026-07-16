import 'package:flutter/material.dart';

class AppColors {
  // Modern Gradient Colors
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF10B981); // Emerald
  static const Color secondaryDark = Color(0xFF059669);
  static const Color secondaryLight = Color(0xFF34D399);
  
  // Accent Colors
  static const Color accent = Color(0xFFF43F5E); // Rose
  static const Color accentLight = Color(0xFFFB7185);
  
  // Background Colors with Gradient Support
  static const Color background = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B);
  
  // Glassmorphism Colors
  static const Color glassLight = Color(0xFFFFFFFF);
  static const Color glassDark = Color(0xFF1E293B);
  static const Color glassBorderLight = Color(0x1A000000);
  static const Color glassBorderDark = Color(0x33FFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textOnDark = Color(0xFFF8FAFC);
  static const Color textOnDarkSecondary = Color(0xFF94A3B8);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  
  // Crowd Density Colors
  static const Color crowdLow = Color(0xFF10B981);
  static const Color crowdMedium = Color(0xFFF59E0B);
  static const Color crowdHigh = Color(0xFFF97316);
  static const Color crowdCritical = Color(0xFFEF4444);
  
  // Emergency Colors
  static const Color emergencyLow = Color(0xFF10B981);
  static const Color emergencyMedium = Color(0xFFF59E0B);
  static const Color emergencyHigh = Color(0xFFEF4444);
  static const Color emergencyCritical = Color(0xFFDC2626);
  
  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF334155);
  
  // Divider Colors
  static const Color dividerLight = Color(0xFFE2E8F0);
  static const Color dividerDark = Color(0xFF334155);
  
  // Shadow Colors
  static const Color shadow = Color(0x0A000000);
  static const Color shadowLight = Color(0x1A000000);
  
  // Gradient Definitions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFF43F5E), Color(0xFFEC4899)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0x33FFFFFF), Color(0x1AFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
