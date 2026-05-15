import 'package:flutter/material.dart';
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
  final VoidCallback?
  onPressed; // Korrigerat till nullable för att tillåta inaktivering
  final bool outlined;

  const NavButton({
    super.key,
    required this.label,
    this.onPressed, // Tog bort required för att tillåta null
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = outlined ? Colors.white : CheckoutTheme.green;
    final Color fg = outlined ? Colors.black : Colors.white;

    // Definiera kantlinje om knappen är 'outlined'
    final BorderSide side =
        outlined
            ? const BorderSide(color: Colors.black, width: 1.5)
            : BorderSide.none;

    return ElevatedButton(
      onPressed:
          onPressed, // Flutter inaktiverar knappen automatiskt om onPressed är null
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        // Färger för inaktiverat läge (när onPressed är null)
        disabledBackgroundColor: Colors.grey[300],
        disabledForegroundColor: Colors.grey[600],
        elevation: outlined ? 0 : 2,
        side: side,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.paddingLarge,
          vertical: AppTheme.paddingMedium,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
      padding: const EdgeInsets.only(bottom: 6, top: 12),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
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
  final double? width;

  const CheckoutTextField({
    super.key,
    required this.controller,
    this.hint,
    this.keyboardType,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: CheckoutTheme.textMuted,
            fontSize: 13,
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
              color: CheckoutTheme.green,
              width: 1.5,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: grey ? CheckoutTheme.textMuted : CheckoutTheme.textDark,
              fontSize: 15,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
