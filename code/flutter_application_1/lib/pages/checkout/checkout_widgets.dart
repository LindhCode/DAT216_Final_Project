import 'package:flutter/material.dart';
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
      margin: margin ?? const EdgeInsets.only(bottom: CheckoutTheme.spaceMediumSmall),
      padding: const EdgeInsets.all(CheckoutTheme.spaceMedium),
      decoration: BoxDecoration(
        color: CheckoutTheme.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: CheckoutTheme.border),
      ),
      child: child,
    );
  }
}

// ── Navigation button ──
class NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool outlined;

  const NavButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    // Använder CheckoutTheme konstanter
    final Color bg = outlined ? Colors.white : CheckoutTheme.green;
    final Color fg = outlined ? CheckoutTheme.textDark : Colors.white;
    
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        padding: const EdgeInsets.symmetric(
          horizontal: CheckoutTheme.spaceLarge,
          vertical: 14, // Matcha bild
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18), // Matcha bild (runda)
          side: outlined
              ? const BorderSide(color: CheckoutTheme.border)
              : BorderSide.none,
        ),
        elevation: outlined ? 0 : 1,
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (outlined) ...[
          const Icon(Icons.arrow_back, size: 15),
          const SizedBox(width: CheckoutTheme.spaceSmall),
        ],
        Text(label,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600)),
        if (!outlined) ...[
          const SizedBox(width: CheckoutTheme.spaceSmall),
          const Icon(Icons.arrow_forward, size: 15),
        ],
      ]),
    );
  }
}

// ── Summary row (for Step 4) ──
class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  final bool grey; // Grå text-stöd förort/adress

  const SummaryRow(this.label, this.value, {
    super.key, 
    this.bold = false,
    this.grey = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 14,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: grey ? CheckoutTheme.textMuted : CheckoutTheme.textDark,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: CheckoutTheme.spaceTiny),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}

// ── Field label (grey) ──
class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: CheckoutTheme.spaceTiny, top: CheckoutTheme.spaceTiny),
        child: Text(text,
            style: const TextStyle(
                fontSize: 13, color: CheckoutTheme.textMuted)),
      );
}

// ── Styled text field ──
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
    final txf = TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
            color: CheckoutTheme.textMuted, fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CheckoutTheme.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: CheckoutTheme.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              color: CheckoutTheme.green, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );

    if (width != null) {
      return SizedBox(width: width, child: txf);
    }
    return txf;
  }
}