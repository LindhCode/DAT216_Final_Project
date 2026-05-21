import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'checkout_theme.dart';

// ── Rounded card wrapper ──
class CheckoutCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;

  const CheckoutCard({super.key, required this.child, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin:
          margin ?? const EdgeInsets.only(bottom: AppTheme.paddingMediumSmall),
      padding: const EdgeInsets.all(AppTheme.paddingMedium),
      decoration: BoxDecoration(
        color: CheckoutTheme.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: CheckoutTheme.border),
      ),
      child: child,
    );
  }
}

// ── Navigation button ──
class NavButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool outlined;

  const NavButton({
    super.key,
    required this.label,
    this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = outlined ? AppTheme.cardBackground : CheckoutTheme.green;
    final Color fg = outlined ? AppTheme.colorBlack : AppTheme.colorWhite;

    final BorderSide side =
        outlined
            ? const BorderSide(
              color: AppTheme.colorBlack,
              width: AppTheme.borderEmphasis,
            )
            : BorderSide.none;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        disabledBackgroundColor: AppTheme.buttonDisabledBackground,
        disabledForegroundColor: AppTheme.buttonDisabledForeground,
        elevation: outlined ? AppTheme.elevationNone : AppTheme.elevationLow,
        side: side,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.paddingLarge,
          vertical: AppTheme.paddingMedium,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppTheme.fontSizeBodyLarge,
        ),
      ),
    );
  }
}

// ── Field Label ──
class FieldLabel extends StatelessWidget {
  final String label;
  const FieldLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppTheme.paddingXSmall,
        top: AppTheme.paddingMediumSmall,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: AppTheme.fontSizeBody,
          fontWeight: FontWeight.w500,
          color: CheckoutTheme.textDark,
        ),
      ),
    );
  }
}

// ── Checkout TextField ──
class CheckoutTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double? width;
  final bool enabled;
  final Color? textColor;

  const CheckoutTextField({
    super.key,
    required this.controller,
    this.hint,
    this.keyboardType,
    this.inputFormatters,
    this.width,
    this.enabled = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextField(
        style: TextStyle(color: textColor ?? AppTheme.colorBlack),
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        cursorColor: AppTheme.colorBlack,
        enabled: enabled,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: CheckoutTheme.textMuted,
            fontSize: AppTheme.fontSizeSmall,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppTheme.paddingMediumSmall,
            vertical: AppTheme.paddingCompact,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            borderSide: const BorderSide(color: CheckoutTheme.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            borderSide: const BorderSide(color: CheckoutTheme.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            borderSide: const BorderSide(
              color: AppTheme.grey700,
              width: AppTheme.borderEmphasis,
            ),
          ),
          filled: true,
          fillColor: AppTheme.cardBackground,
        ),
      ),
    );
  }
}

// ── Summary Row ──
class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  final bool grey;

  const SummaryRow(
    this.label,
    this.value, {
    super.key,
    this.bold = false,
    this.grey = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.paddingTiny),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: grey ? CheckoutTheme.textMuted : CheckoutTheme.textDark,
              fontSize: AppTheme.fontSizeBodyLarge,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontSize: AppTheme.fontSizeBodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
