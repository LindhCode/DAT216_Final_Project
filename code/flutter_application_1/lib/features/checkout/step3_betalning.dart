import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'checkout_theme.dart';
import 'checkout_widgets.dart';

class Step3Betalning extends StatelessWidget {
  final int paymentMethod;
  final ValueChanged<int> onMethodChanged;
  final TextEditingController cardFirstCtrl,
      cardLastCtrl,
      cardNumberCtrl,
      expiryCtrl,
      cvcCtrl;
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
      listenable: Listenable.merge([
        cardFirstCtrl,
        cardLastCtrl,
        cardNumberCtrl,
        expiryCtrl,
        cvcCtrl,
      ]),
      builder: (context, _) {
        bool isValid =
            paymentMethod != 1 ||
            (cardFirstCtrl.text.isNotEmpty &&
                cardLastCtrl.text.isNotEmpty &&
                cardNumberCtrl.text.length >= 16 &&
                expiryCtrl.text.isNotEmpty &&
                cvcCtrl.text.length >= 3);

        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Column(
            children: [
              const Text(
                '3. Betalning',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              CheckoutCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOption(0, 'Klarna', const _KlarnaLogo()),
                    _buildOption(1, 'Bankkort', const _BankLogo()),
                    if (paymentMethod == 1) _buildCardForm(),
                    _buildOption(2, 'Swish', const _SwishLogo()),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.paddingMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavButton(
                    label: '< Tillbaka',
                    onPressed: onPrev,
                    outlined: true,
                  ),
                  NavButton(
                    label: 'Slutför >',
                    onPressed: isValid ? onNext : null,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOption(int value, String label, Widget logo) {
    return InkWell(
      onTap: () => onMethodChanged(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Radio<int>(
              value: value,
              groupValue: paymentMethod,
              onChanged: (v) => onMethodChanged(v!),
              activeColor: CheckoutTheme.green,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            logo,
          ],
        ),
      ),
    );
  }

  Widget _buildCardForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 48, right: 16, bottom: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldLabel('Förnamn'),
                    CheckoutTextField(controller: cardFirstCtrl),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.paddingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldLabel('Efternamn'),
                    CheckoutTextField(controller: cardLastCtrl),
                  ],
                ),
              ),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldLabel('Utgångsdatum'),
                    CheckoutTextField(controller: expiryCtrl, hint: 'MM/ÅÅ'),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.paddingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldLabel('CVC'),
                    CheckoutTextField(controller: cvcCtrl, hint: 'xxx'),
                  ],
                ),
              ),
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
    decoration: BoxDecoration(
      color: const Color(0xFFFFB3C7),
      borderRadius: BorderRadius.circular(4),
    ),
    child: const Text(
      'Klarna.',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 12,
        color: Colors.black,
      ),
    ),
  );
}

class _BankLogo extends StatelessWidget {
  const _BankLogo();
  @override
  Widget build(BuildContext context) =>
      const Icon(Icons.credit_card, color: CheckoutTheme.textDark);
}

class _SwishLogo extends StatelessWidget {
  const _SwishLogo();
  @override
  Widget build(BuildContext context) => const Text('Swish Logo Placeholder');
}
