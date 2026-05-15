import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'checkout_theme.dart';
import 'checkout_widgets.dart';

class Step3Betalning extends StatelessWidget {
  final int paymentMethod;
  final ValueChanged<int> onMethodChanged;
  final TextEditingController cardFirstCtrl, cardLastCtrl, cardNumberCtrl, expiryCtrl, cvcCtrl;
  final VoidCallback onNext, onPrev;

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
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([cardFirstCtrl, cardLastCtrl, cardNumberCtrl, expiryCtrl, cvcCtrl]),
      builder: (context, _) {
        // Validering: Om bankkort (1) är valt måste fälten vara fyllda. 
        // Om Klarna (0) eller Swish (2) är valt är det alltid "valid" i detta steg.
        bool isValid = paymentMethod != 1 ||
            (cardFirstCtrl.text.isNotEmpty &&
                cardLastCtrl.text.isNotEmpty &&
                cardNumberCtrl.text.length == 16 &&
                expiryCtrl.text.isNotEmpty &&
                cvcCtrl.text.isNotEmpty);

        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  '3. Betalning',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: AppTheme.paddingLarge),
              const Text('Välj betalsätt...', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: AppTheme.paddingCompact),
              
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

              // Dynamiskt innehåll baserat på val
              if (paymentMethod == 1)
                _CardDetailsCard(
                  cardFirstCtrl: cardFirstCtrl,
                  cardLastCtrl: cardLastCtrl,
                  cardNumberCtrl: cardNumberCtrl,
                  expiryCtrl: expiryCtrl,
                  cvcCtrl: cvcCtrl,
                )
              else if (paymentMethod == 0)
                const CheckoutCard(
                  child: Text("Du kommer att skickas vidare till Klarna för att slutföra betalningen efter att du klickat på Slutför."),
                )
              else if (paymentMethod == 2)
                const CheckoutCard(
                  child: Text("Öppna Swish-appen på din telefon efter att du klickat på Slutför för att godkänna betalningen."),
                ),

              const SizedBox(height: AppTheme.paddingMedium),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavButton(label: 'Tillbaka', onPressed: onPrev, outlined: true),
                  NavButton(label: 'Slutför', onPressed: isValid ? onNext : null),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Hjälp-widgets (De som saknades) ──

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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.paddingMedium),
        decoration: BoxDecoration(
          color: selected ? CheckoutTheme.green.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: selected ? CheckoutTheme.green : CheckoutTheme.border,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            logo,
            const SizedBox(width: AppTheme.paddingMedium),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: selected ? CheckoutTheme.green : CheckoutTheme.textDark,
                ),
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? CheckoutTheme.green : CheckoutTheme.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _CardDetailsCard extends StatelessWidget {
  final TextEditingController cardFirstCtrl, cardLastCtrl, cardNumberCtrl, expiryCtrl, cvcCtrl;

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
          Row(
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const FieldLabel('Förnamn'), CheckoutTextField(controller: cardFirstCtrl)])),
              const SizedBox(width: AppTheme.paddingMedium),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const FieldLabel('Efternamn'), CheckoutTextField(controller: cardLastCtrl)])),
            ],
          ),
          const FieldLabel('Kortnummer'),
          CheckoutTextField(
            controller: cardNumberCtrl,
            hint: 'xxxx xxxx xxxx xxxx',
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const FieldLabel('Utgångsdatum'), CheckoutTextField(controller: expiryCtrl, hint: 'MM/ÅÅ')])),
              const SizedBox(width: AppTheme.paddingMedium),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const FieldLabel('CVC'), CheckoutTextField(controller: cvcCtrl, hint: 'xxx')])),
            ],
          ),
        ],
      ),
    );
  }
}

class _KlarnaLogo extends StatelessWidget {
  const _KlarnaLogo();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: const Color(0xFFFFB3C7), borderRadius: BorderRadius.circular(4)),
    child: Text('Klarna.', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.black)),
  );
}

class _BankLogo extends StatelessWidget {
  const _BankLogo();
  @override
  Widget build(BuildContext context) => const Icon(Icons.credit_card, color: CheckoutTheme.textDark);
}

class _SwishLogo extends StatelessWidget {
  const _SwishLogo();
  @override
  Widget build(BuildContext context) => Container(
    width: 24,
    height: 24,
    decoration: const BoxDecoration(color: Color(0xFF2DABE2), shape: BoxShape.circle),
    child: const Center(child: Icon(Icons.import_export, size: 16, color: Colors.white)),
  );
}