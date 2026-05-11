import 'package:flutter/material.dart';

class AppTheme {
  // Padding & Spacing
  static const double paddingTiny = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMediumSmall = 12.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingHuge = 32.0;

  // Färger extraherade från iMat-designen
  static const Color primaryGreen = Color(0xFF689451); // Knappar och logotyp
  static const Color darkGreen = Color(0xFF3B5B28);    // Hover-effekter eller mörkare detaljer
  static const Color accentRed = Color(0xFFB54D3F);    // "Töm varukorgen" och favorit-hjärtan
  static const Color backgroundLight = Color(0xFFF5F5F5); // Ljusgrå bakgrund bakom korten
  static const Color cardBackground = Colors.white;    // Vit bakgrund för produktkort
  static const Color sidebarBackground = Color(0xFFE0E0E0); // Sidopanelens bakgrund
  static const Color textMain = Color(0xFF333333);     // Huvudtext (svart/mörkgrå)
  static const Color textSecondary = Color(0xFF666666); // Undertext (t.ex. vikt/klass)
  static const Color priceYellow = Color(0xFFFFEB3B);  // Bakgrund för prislappar

  // ColorScheme konfiguration
  static ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: primaryGreen,
    primary: primaryGreen,
    secondary: accentRed,
    surface: cardBackground,
    background: backgroundLight,
    onPrimary: Colors.white,
    onSurface: textMain,
  );
  // ThemeData för hela appen
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Poppins', // Sätter Poppins som global font
      scaffoldBackgroundColor: backgroundLight,
      
      // Enhetlig stil för knappar (t.ex. "Lägg i varukorg")
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),

      // Textstyling
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: textMain,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        bodyLarge: TextStyle(color: textMain, fontSize: 16),
        bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
      ),
    );
  }
}