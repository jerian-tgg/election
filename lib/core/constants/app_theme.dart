import 'package:flutter/material.dart';

class AppTheme {
  // Colors - Updated to match the blue gradient design
  static const Color primaryColor = Color(0xFF2E7DD8); // Primary Blue
  static const Color secondaryColor = Color(0xFF4A90E2); // Secondary Blue
  static const Color accentColor = Color(0xFF6BA6F5); // Light Blue
  static const Color backgroundColor = Color(0xFFF8F9FA); // Light Gray Background
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFDC3545);
  static const Color successColor = Color(0xFF28A745);
  static const Color textPrimaryColor = Color(0xFF212529);
  static const Color textSecondaryColor = Color(0xFF6C757D);
  static const Color cardBackgroundColor = Color(0xFFFFFFFF);

  // Gradient Colors (for the blue gradient header)
  static const Color gradientStart = Color(0xFF1E5AB8); // Dark Blue
  static const Color gradientEnd = Color(0xFF4A90E2); // Light Blue

  // Additional UI Colors
  static const Color dividerColor = Color(0xFFE9ECEF);
  static const Color lightBlue = Color(0xFFE3F2FD);
  static const Color voteButtonColor = Color(0xFF007BFF);

  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white, // White text for headers on blue background
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimaryColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: textPrimaryColor,
  );

  static const TextStyle captionStyle = TextStyle(
    fontSize: 14,
    color: textSecondaryColor,
  );

  static const TextStyle whiteTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;

  // Border Radius
  static const double borderRadiusS = 4.0;
  static const double borderRadiusM = 8.0;
  static const double borderRadiusL = 12.0;
  static const double borderRadiusXL = 16.0;

  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> headerShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  // Gradient for header/dashboard
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );

  // Theme Data
  static ThemeData get theme => ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      background: backgroundColor,
      surface: surfaceColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: voteButtonColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: spacingL,
          vertical: spacingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusM),
        ),
        elevation: 2,
      ),
    ),
    cardTheme: CardThemeData(
      color: cardBackgroundColor,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusL),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusM),
        borderSide: BorderSide(color: dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusM),
        borderSide: BorderSide(color: dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusM),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusM),
        borderSide: const BorderSide(color: errorColor),
      ),
      contentPadding: const EdgeInsets.all(spacingM),
    ),
    dividerTheme: const DividerThemeData(
      color: dividerColor,
      thickness: 1,
    ),
  );

  // Helper method to create gradient containers
  static BoxDecoration get gradientDecoration => BoxDecoration(
    gradient: primaryGradient,
    boxShadow: headerShadow,
  );

  // Helper method for stat cards (like the time remaining and positions cards)
  static BoxDecoration get statCardDecoration => BoxDecoration(
    color: Colors.white.withOpacity(0.2),
    borderRadius: BorderRadius.circular(borderRadiusL),
    border: Border.all(
      color: Colors.white.withOpacity(0.3),
      width: 1,
    ),
  );
}