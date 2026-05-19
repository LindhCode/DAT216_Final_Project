import 'package:flutter/material.dart';

class AppTheme {
  // ── Padding & spacing ─────────────────────────────────────────────────────
  static const double paddingTiny = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMediumSmall = 12.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingHuge = 32.0;

  static const double paddingMicro = 3.0;
  static const double paddingXSmall = 6.0;
  static const double paddingCompact = 10.0;
  static const double paddingBlock = 14.0;
  static const double paddingInset = 20.0;
  static const double paddingSection = 30.0;
  static const double paddingHero = 40.0;
  static const double paddingWide = 50.0;
  static const double paddingPage = 100.0;

  // ── Border radii ──────────────────────────────────────────────────────────
  static const double radiusTight = 4.0;
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 10.0;
  static const double radiusLarge = 12.0;
  static const double radiusControl = 18.0;
  static const double radiusPill = 20.0;
  static const double radiusRound = 25.0;
  static const double radiusModal = 16.0;
  static const double radiusFavorite = 32.0;
  static const double radiusStadium = 100.0;
  static const double radiusFull = 999.0;

  // ── Font sizes ────────────────────────────────────────────────────────────
  static const double fontSizeCaption = 16.0;
  static const double fontSizeSmall = 17.0;
  static const double fontSizeBody = 18.0;
  static const double fontSizeBodyLarge = 19.0;
  static const double fontSizeSubtitle = 20.0;
  static const double fontSizePrice = 21.0;
  static const double fontSizeTitle = 22.0;
  static const double fontSizeHeadingSmall = 24.0;
  static const double fontSizeHeading = 26.0;
  static const double fontSizeHeadingLarge = 28.0;
  static const double fontSizeDisplaySmall = 30.0;
  static const double fontSizeDisplay = 36.0;
  static const double fontSizePriceModal = 24.0;
  static const double fontSizePriceHero = 30.0;

  // ── Icon sizes ────────────────────────────────────────────────────────────
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 18.0;
  static const double iconSizeStandard = 20.0;
  static const double iconSizeNav = 22.0;
  static const double iconSizeLarge = 24.0;
  static const double iconSizeCategory = 28.0;

  // ── Button heights ────────────────────────────────────────────────────────
  static const double buttonHeightSmall = 38.0;
  static const double buttonHeightCompact = 42.0;
  static const double buttonHeightStandard = 44.0;
  static const double buttonHeightMedium = 48.0;
  static const double buttonHeightLarge = 52.0;

  // ── Layout dimensions ───────────────────────────────────────────────────────
  static const double navbarHeight = 65.0;
  static const double navbarLogoHeight = 55.0;
  static const double searchBarHeight = 42.0;
  static const double searchBarWidth = 500.0;
  static const double cartSidebarWidth = 300.0;
  static const double categorySidebarWidth = 250.0;
  static const double contentWidthNarrow = 600.0;
  static const double contentWidthCheckout = 700.0;
  static const double contentWidthPayment = 650.0;
  static const double checkoutQuantityColumnWidth = 80.0;
  static const double checkoutPriceColumnWidth = 96.0;
  static const double checkoutActionColumnWidth = 120.0;
  static const double modalMaxWidth = 560.0;
  static const double modalImageHeight = 260.0;
  static const double checkoutLogoSize = 36.0;
  static const double stepChevronWidth = 160.0;
  static const double stepChevronHeight = 14.0;
  static const double dividerHeight = 1.0;

  // ── Typography extras ─────────────────────────────────────────────────────
  static const double letterSpacingTight = -0.2;
  static const double letterSpacingWide = 0.2;
  static const double lineHeightCompact = 1.15;
  static const double lineHeightRelaxed = 1.45;

  // ── Grid layout ─────────────────────────────────────────────────────────────
  static const double gridAspectRatioCard = 0.85;
  static const double gridAspectRatioHome = 0.75;

  // ── Image cache bounds ──────────────────────────────────────────────────────
  static const int imageCacheWidthMin = 180;
  static const int imageCacheWidthMax = 960;

  static const EdgeInsets paddingNone = EdgeInsets.zero;

  // ── Border widths ───────────────────────────────────────────────────────────
  static const double borderThin = 0.5;
  static const double borderStandard = 1.0;
  static const double borderEmphasis = 1.5;
  static const double borderBold = 2.0;

  // ── Elevation ───────────────────────────────────────────────────────────────
  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;

  // ── Shadow presets ──────────────────────────────────────────────────────────
  static const double shadowBlurTiny = 2.0;
  static const double shadowBlurSmall = 4.0;
  static const double shadowBlurMedium = 8.0;
  static const double shadowBlurLarge = 10.0;
  static const double shadowBlurModal = 24.0;
  static const Offset shadowOffsetSmall = Offset(0, 1);
  static const Offset shadowOffsetMedium = Offset(0, 2);
  static const Offset shadowOffsetCard = Offset(0, 4);
  static const Offset shadowOffsetModal = Offset(0, 8);

  // ── Core palette (iMat design) ────────────────────────────────────────────
  static const Color primaryGreen = Color(0xFF689451);
  static const Color darkGreen = Color(0xFF3B5B28);
  static const Color accentRed = Color(0xFFB54D3F);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color sidebarBackground = Color(0xFFE0E0E0);
  static const Color textMain = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textCharcoal = Color(0xFF1A1A1A);
  static const Color priceYellow = Color(0xFFFFEB3B);

  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorBlack = Color(0xFF000000);
  static const Color colorTransparent = Color(0x00000000);

  // ── Greys ───────────────────────────────────────────────────────────────────
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color.fromARGB(255, 118, 118, 118);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey900 = Color(0xFF212121);

  // ── Navbar & checkout chrome ──────────────────────────────────────────────
  static const Color navbarDark = grey900;
  static const Color checkoutBarDark = Color(0xFF1B1B1B);
  static const Color stepChevronActive = Color(0xFF4C8C4A);
  static const Color stepInactive = grey400;

  // ── Text & surfaces on dark backgrounds ───────────────────────────────────
  static const Color onDarkPrimary = colorWhite;
  static const Color onDarkSecondary = Color(0xB3FFFFFF);
  static const Color onDarkMuted = Color(0x8AFFFFFF);
  static const Color onDarkHint = Color(0x61FFFFFF);
  static const Color onDarkSubtle = Color(0x1AFFFFFF);
  static const Color onDarkSurface = Color(0x1FFFFFFF);
  static const Color onDarkBorder = Color(0x3DFFFFFF);

  // ── Muted / overlay text on light backgrounds ─────────────────────────────
  static const Color textMutedStrong = Color(0xDE000000);
  static const Color textMutedMedium = Color(0x99000000);

  // ── Primary green with alpha ────────────────────────────────────────────────
  static const Color primaryGreen05 = Color(0x0D689451);
  static const Color primaryGreen12 = Color(0x1F689451);
  static const Color primaryGreen25 = Color(0x40689451);

  // ── Scrim & shadows (pre-computed alpha) ────────────────────────────────────
  static const Color scrimDark = Color(0x73000000);
  static const Color shadowBlack02 = Color(0x05000000);
  static const Color shadowBlack03 = Color(0x08000000);
  static const Color shadowBlack05 = Color(0x0D000000);
  static const Color shadowBlack12 = Color(0x1F000000);
  static const Color shadowBlack15 = Color(0x26000000);
  static const Color borderSubtle = Color(0x1F000000);
  static const Color imagePlaceholderTint = Color(0x08000000);
  static const Color favoriteButtonSurface = Color(0xE6FFFFFF);
  static const Color dividerMuted = Color(0x599E9E9E);

  // ── Payment brand colours ───────────────────────────────────────────────────
  static const Color klarnaPink = Color(0xFFFFB3C7);
  static const Color swishBlue = Color(0xFF2DABE2);

  // ── Disabled button states ──────────────────────────────────────────────────
  static const Color buttonDisabledBackground = grey300;
  static const Color buttonDisabledForeground = grey600;

  static ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: primaryGreen,
    primary: primaryGreen,
    secondary: accentRed,
    surface: cardBackground,
    background: backgroundLight,
    onPrimary: colorWhite,
    onSurface: textMain,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: backgroundLight,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: colorWhite,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: textMain,
          fontWeight: FontWeight.bold,
          fontSize: fontSizeHeadingLarge,
        ),
        bodyLarge: TextStyle(color: textMain, fontSize: fontSizeSubtitle),
        bodyMedium: TextStyle(color: textSecondary, fontSize: fontSizeBody),
      ),
    );
  }
}
