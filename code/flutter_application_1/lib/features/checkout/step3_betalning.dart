import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'checkout_theme.dart';
import 'checkout_widgets.dart';

class Step3Betalning extends StatelessWidget {
  final int paymentMethod; // 0=Klarna  1=Bank  2=Swish
  final ValueChanged<int> onMethodChanged;

  final TextEditingController cardFirstCtrl;
  final TextEditingController cardLastCtrl;
  final TextEditingController cardNumberCtrl;
  final TextEditingController expiryCtrl;
  final TextEditingController cvcCtrl;

  final VoidCallback onNext;

  const Step3Betalning({
    super.key,
    required this.paymentMethod,
    required this.onMethodChanged,
    required this.cardFirstCtrl,
    required this.cardLastCtrl,
    required this.cardNumberCtrl,
    required this.expiryCtrl,
    required this.cvcCtrl,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 650),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              '3. Betalning',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: CheckoutTheme.textDark,
              ),
            ),
          ),
          const SizedBox(height: AppTheme.paddingLarge),

          const Text(
            'Välj betalsätt...',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppTheme.paddingCompact),

          // Payment options - matcha image_2.png layout
          _PaymentOption(
            index: 0,
            selected: paymentMethod == 0,
            onTap: () => onMethodChanged(0),
            logo: const _KlarnaLogo(),
            label: 'Betala med Klarna',
          ),
          const SizedBox(height: AppTheme.paddingXSmall),
          _PaymentOption(
            index: 1,
            selected: paymentMethod == 1,
            onTap: () => onMethodChanged(1),
            logo: const _BankLogo(),
            label: 'Betala med bank',
          ),
          const SizedBox(height: AppTheme.paddingXSmall),
          _PaymentOption(
            index: 2,
            selected: paymentMethod == 2,
            onTap: () => onMethodChanged(2),
            logo: const _SwishLogo(),
            label: 'Betala med Swish',
          ),

          const SizedBox(height: AppTheme.paddingMedium),

          // Card details CARD – placement according to image_2.png
          // Only shown when Bank is selected
          if (paymentMethod == 1)
            _CardDetailsCard(
              cardFirstCtrl: cardFirstCtrl,
              cardLastCtrl: cardLastCtrl,
              cardNumberCtrl: cardNumberCtrl,
              expiryCtrl: expiryCtrl,
              cvcCtrl: cvcCtrl,
            ),

          const SizedBox(height: AppTheme.paddingMedium),
          Align(
            alignment: Alignment.centerRight,
            child: NavButton(label: 'Slutför', onPressed: onNext),
          ),
          const SizedBox(height: AppTheme.paddingLarge),
        ],
      ),
    );
  }
}

// ── Selectable payment row, adjusted to image_2.png ──
class _PaymentOption extends StatelessWidget {
  final int index;
  final bool selected;
  final VoidCallback onTap;
  final Widget logo;
  final String label;

  const _PaymentOption({
    required this.index,
    required this.selected,
    required this.onTap,
    required this.logo,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.paddingBlock,
          vertical: AppTheme.paddingMediumSmall,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: selected ? CheckoutTheme.green : CheckoutTheme.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<int>(
              value: index,
              groupValue: selected ? index : -1,
              onChanged: (_) => onTap(),
              // Matcha skiss, radio-knappen är mörk
              activeColor: CheckoutTheme.textDark,
            ),
            const SizedBox(width: AppTheme.paddingSmall),
            logo,
            const SizedBox(width: AppTheme.paddingMediumSmall),
            Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Card details form, simplified layout matching image_2.png ──
class _CardDetailsCard extends StatelessWidget {
  final TextEditingController cardFirstCtrl;
  final TextEditingController cardLastCtrl;
  final TextEditingController cardNumberCtrl;
  final TextEditingController expiryCtrl;
  final TextEditingController cvcCtrl;

  const _CardDetailsCard({
    required this.cardFirstCtrl,
    required this.cardLastCtrl,
    required this.cardNumberCtrl,
    required this.expiryCtrl,
    required this.cvcCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return CheckoutCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Uppgifter...',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppTheme.paddingBlock),

          // Name form - simplified to single row
          Row(
            children: [
              Expanded(child: const FieldLabel('Namn på kortet Förnamn')),
              Expanded(child: const FieldLabel('Efternamn')),
            ],
          ),
          Row(
            children: [
              Expanded(child: CheckoutTextField(controller: cardFirstCtrl)),
              const SizedBox(width: AppTheme.paddingBlock),
              Expanded(child: CheckoutTextField(controller: cardLastCtrl)),
            ],
          ),

          const SizedBox(height: AppTheme.paddingMediumSmall),
          const FieldLabel('Kortuppgifter Kortnummer'),
          TextField(
            controller: cardNumberCtrl,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
            ],
            decoration: _inputDec(hint: 'Kortnummer'),
          ),
          const SizedBox(height: AppTheme.paddingMediumSmall),

          Row(
            children: [
              CheckoutTextField(
                controller: expiryCtrl,
                width: 140,
                hint: 'MM/YY',
              ),
              const SizedBox(width: AppTheme.paddingBlock),
              CheckoutTextField(controller: cvcCtrl, width: 100, hint: 'CVC'),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDec({String? hint}) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: CheckoutTheme.textMuted, fontSize: 13),
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
      borderSide: const BorderSide(color: CheckoutTheme.green, width: 1.5),
    ),
    filled: true,
    fillColor: Colors.white,
  );
}

// ── Payment logos from sketches ──
class _KlarnaLogo extends StatelessWidget {
  const _KlarnaLogo();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppTheme.paddingSmall,
      vertical: AppTheme.paddingMicro,
    ),
    decoration: BoxDecoration(
      color: const Color(0xFFFFB3C7),
      borderRadius: BorderRadius.circular(AppTheme.radiusTight),
    ),
    child: const Text(
      'Klarna',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Color(0xFF1A1A2E),
      ),
    ),
  );
}

class _BankLogo extends StatelessWidget {
  const _BankLogo();
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: Color(0xFFEB5757),
          shape: BoxShape.circle,
        ),
      ),
      Transform.translate(
        offset: Offset(-AppTheme.paddingSmall, 0),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFFF8A93E).withValues(alpha: 0.9),
            shape: BoxShape.circle,
          ),
        ),
      ),
      Transform.translate(
        offset: Offset(-AppTheme.paddingMediumSmall, 0),
        child: const Text(
          'VISA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Color(0xFF1A1F71),
          ),
        ),
      ),
    ],
  );
}

class _SwishLogo extends StatelessWidget {
  const _SwishLogo();
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text('⟳', style: TextStyle(fontSize: 17, color: Color(0xFFFF5A00))),
      SizedBox(width: AppTheme.paddingMicro),
      Text(
        'swish',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Color(0xFF1A1A1A),
        ),
      ),
    ],
  );
}
