// checkout_theme.dart
//
// All colour and spacing constants now delegate to AppTheme so the
// checkout flow stays in sync with the rest of the app.
//
// The only additions are step-indicator colours that are not part of
// AppTheme; everything else is a direct alias.

import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';

class CheckoutTheme {
  // ── Colours ───────────────────────────────────────────────────────────────
  static const Color green     = AppTheme.primaryGreen;
  static const Color darkGreen = AppTheme.darkGreen;
  static const Color red       = AppTheme.accentRed;
  static const Color bg        = AppTheme.backgroundLight;
  static const Color card      = AppTheme.cardBackground;
  static const Color textDark  = AppTheme.textMain;
  static const Color textMuted = AppTheme.textSecondary;
  static const Color border    = AppTheme.sidebarBackground;

  // Step-indicator states (no direct AppTheme equivalent)
  static const Color stepDone     = AppTheme.darkGreen;
  static const Color stepActive   = AppTheme.primaryGreen;
  static const Color stepInactive = Color(0xFFBDBDBD);

  // ── Spacing ───────────────────────────────────────────────────────────────
  static const double spaceTiny        = AppTheme.paddingTiny;
  static const double spaceSmall       = AppTheme.paddingSmall;
  static const double spaceMediumSmall = AppTheme.paddingMediumSmall;
  static const double spaceMedium      = AppTheme.paddingMedium;
  static const double spaceLarge       = AppTheme.paddingLarge;
  static const double spaceHuge        = AppTheme.paddingHuge;
}
