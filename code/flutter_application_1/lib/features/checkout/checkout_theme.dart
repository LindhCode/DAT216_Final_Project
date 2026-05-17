// checkout_theme.dart
//
// Checkout-specific aliases; all values live in [AppTheme].

import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';

class CheckoutTheme {
  static const Color green = AppTheme.primaryGreen;
  static const Color darkGreen = AppTheme.darkGreen;
  static const Color red = AppTheme.accentRed;
  static const Color bg = AppTheme.backgroundLight;
  static const Color card = AppTheme.cardBackground;
  static const Color textDark = AppTheme.textMain;
  static const Color textMuted = AppTheme.textSecondary;
  static const Color border = AppTheme.sidebarBackground;

  static const Color stepDone = AppTheme.darkGreen;
  static const Color stepActive = AppTheme.primaryGreen;
  static const Color stepInactive = AppTheme.stepInactive;
}
