// checkout_theme.dart
//
// Checkout-specific colours; layout spacing and radii live in [AppTheme].
//
// Step-indicator colours have no direct [AppTheme] equivalent.

import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';

class CheckoutTheme {
  // ── Colours ───────────────────────────────────────────────────────────────
  static const Color green = AppTheme.primaryGreen;
  static const Color darkGreen = AppTheme.darkGreen;
  static const Color red = AppTheme.accentRed;
  static const Color bg = AppTheme.backgroundLight;
  static const Color card = AppTheme.cardBackground;
  static const Color textDark = AppTheme.textMain;
  static const Color textMuted = AppTheme.textSecondary;
  static const Color border = AppTheme.sidebarBackground;

  // Step-indicator states (no direct AppTheme equivalent)
  static const Color stepDone = AppTheme.darkGreen;
  static const Color stepActive = AppTheme.primaryGreen;
  static const Color stepInactive = Color(0xFFBDBDBD);
}
