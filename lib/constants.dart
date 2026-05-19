import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryGold = Color(0xFFE5A335);
  static const Color darkBlue = Color(0xFF0B1221);
  static const Color lightGrey = Color(0xFFF4F5F7);
  static const Color bgLight = Color(0xFFFAFBFC);
  static const Color white = Colors.white;
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color gradientStart = Color(0xFF0B1221);
  static const Color gradientEnd = Color(0xFF1A2744);
  static const Color cardShadow = Color(0x1A000000);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.darkBlue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.darkBlue,
        primary: AppColors.darkBlue,
        secondary: AppColors.primaryGold,
        surface: AppColors.white,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.bgLight,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.darkBlue),
        titleTextStyle: TextStyle(
          color: AppColors.darkBlue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGold,
          foregroundColor: AppColors.darkBlue,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryGold, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade200,
        thickness: 1,
      ),
    );
  }

  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.03),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];
}
