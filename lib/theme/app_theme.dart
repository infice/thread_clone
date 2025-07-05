import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: Color(0xFF000000),
        onPrimary: Colors.white,
        secondary: const Color(0xFF657786),
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: const Color(0xFF14171A),
        background: const Color(0xFFF7F9FA),
        onBackground: const Color(0xFF14171A),
        error: const Color(0xFFE0245E),
        onError: Colors.white,
        outline: const Color(0xFFE1E8ED),
        outlineVariant: const Color(0xFFE1E8ED),
        surfaceVariant: const Color(0xFFF7F9FA),
        onSurfaceVariant: const Color(0xFF657786),
        shadow: Colors.black12,
        scrim: Colors.black26,
        inverseSurface: const Color(0xFF14171A),
        onInverseSurface: Colors.white,
        inversePrimary: Color(0xFF000000),
        tertiary: const Color(0xFF17BF63),
        onTertiary: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFFF7F9FA),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFFF7F9FA),
        foregroundColor: const Color(0xFF14171A),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color(0xFF14171A),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Color(0xFF14171A)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF000000),
        unselectedItemColor: Color(0xFF657786),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: const CardThemeData(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        shadowColor: Colors.black12,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF000000),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Color(0xFF000000),
          side: BorderSide(color: Color(0xFF000000)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Color(0xFF000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE1E8ED)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE1E8ED)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.reply, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0245E)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0245E), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: const TextStyle(color: Color(0xFF657786)),
        labelStyle: const TextStyle(color: Color(0xFF657786)),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Color(0xFF14171A)),
        displayMedium: TextStyle(color: Color(0xFF14171A)),
        displaySmall: TextStyle(color: Color(0xFF14171A)),
        headlineLarge: TextStyle(color: Color(0xFF14171A)),
        headlineMedium: TextStyle(color: Color(0xFF14171A)),
        headlineSmall: TextStyle(color: Color(0xFF14171A)),
        titleLarge: TextStyle(color: Color(0xFF14171A)),
        titleMedium: TextStyle(color: Color(0xFF14171A)),
        titleSmall: TextStyle(color: Color(0xFF14171A)),
        bodyLarge: TextStyle(color: Color(0xFF14171A)),
        bodyMedium: TextStyle(color: Color(0xFF14171A)),
        bodySmall: TextStyle(color: Color(0xFF657786)),
        labelLarge: TextStyle(color: Color(0xFF14171A)),
        labelMedium: TextStyle(color: Color(0xFF14171A)),
        labelSmall: TextStyle(color: Color(0xFF657786)),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF657786), size: 24),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE1E8ED),
        thickness: 0.5,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Color(0xFF000000),
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.reply,
        onPrimary: Colors.white,
        secondary: const Color(0xFF8899A6),
        onSecondary: Colors.white,
        surface: const Color(0xFF192734),
        onSurface: Colors.white,
        background: const Color(0xFF15202B),
        onBackground: Colors.white,
        error: const Color(0xFFE0245E),
        onError: Colors.white,
        outline: const Color(0xFF38444D),
        outlineVariant: const Color(0xFF38444D),
        surfaceVariant: const Color(0xFF192734),
        onSurfaceVariant: const Color(0xFF8899A6),
        shadow: Colors.black26,
        scrim: Colors.black54,
        inverseSurface: Colors.white,
        onInverseSurface: const Color(0xFF15202B),
        inversePrimary: AppColors.reply,
        tertiary: const Color(0xFF17BF63),
        onTertiary: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF15202B),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF15202B),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF192734),
        selectedItemColor: AppColors.reply,
        unselectedItemColor: Color(0xFF8899A6),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: const CardThemeData(
        color: Color(0xFF192734),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        shadowColor: Colors.black26,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.reply,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.reply,
          side: BorderSide(color: AppColors.reply),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.reply,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF192734),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF38444D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF38444D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.reply, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0245E)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0245E), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: const TextStyle(color: Color(0xFF8899A6)),
        labelStyle: const TextStyle(color: Color(0xFF8899A6)),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        displaySmall: TextStyle(color: Colors.white),
        headlineLarge: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Color(0xFF8899A6)),
        labelLarge: TextStyle(color: Colors.white),
        labelMedium: TextStyle(color: Colors.white),
        labelSmall: TextStyle(color: Color(0xFF8899A6)),
      ),
      iconTheme: const IconThemeData(color: Color(0xFF8899A6), size: 24),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF38444D),
        thickness: 0.5,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.reply,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
