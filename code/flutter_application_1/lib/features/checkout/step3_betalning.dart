import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                cardNumberCtrl.text.replaceAll(' ', '').length == 16 &&
                expiryCtrl.text.length == 5 &&
                cvcCtrl.text.length == 3);

        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppTheme.contentWidthPayment),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  '3. Betalning',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeDisplaySmall,
                    fontWeight: FontWeight.bold,
                    color: CheckoutTheme.textDark,
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.paddingLarge),
              const Text(
                'Välj betalsätt: ',
                style: TextStyle(
                  fontSize: AppTheme.fontSizeHeadingSmall,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMain,
                ),
              ),
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
                  child: Text(
                    "Du kommer att skickas vidare till Klarna för att slutföra betalningen efter att du klickat på Slutför.",
                  ),
                )
              else if (paymentMethod == 2)
                const CheckoutCard(
                  child: Text(
                    "Öppna Swish-appen på din telefon efter att du klickat på Slutför för att godkänna betalningen.",
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
                    label: 'Slutför',
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
}

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
          color:
              selected ? AppTheme.primaryGreen05 : AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: selected ? CheckoutTheme.green : CheckoutTheme.border,
            width: selected ? AppTheme.borderBold : AppTheme.borderStandard,
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
                  color:
                      selected ? CheckoutTheme.green : CheckoutTheme.textDark,
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
  final TextEditingController cardFirstCtrl,
      cardLastCtrl,
      cardNumberCtrl,
      expiryCtrl,
      cvcCtrl;

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
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CardNumberInputFormatter(),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldLabel('Utgångsdatum'),
                    CheckoutTextField(
                      controller: expiryCtrl,
                      hint: 'MM/ÅÅ',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        ExpiryDateInputFormatter(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.paddingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FieldLabel('CVC'),
                    CheckoutTextField(
                      controller: cvcCtrl,
                      hint: 'xxx',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),
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

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final truncated = digits.length > 16 ? digits.substring(0, 16) : digits;
    final buffer = StringBuffer();

    for (var i = 0; i < truncated.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(truncated[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length > 4) digits = digits.substring(0, 4);
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      if (i == 2) buffer.write('/');
      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _KlarnaLogo extends StatelessWidget {
  const _KlarnaLogo();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppTheme.paddingSmall,
      vertical: AppTheme.paddingTiny,
    ),
    decoration: BoxDecoration(
      color: AppTheme.klarnaPink,
      borderRadius: BorderRadius.circular(AppTheme.radiusTight),
    ),
    child: const Text(
      'Klarna.',
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: AppTheme.fontSizeCaption,
        color: AppTheme.colorBlack,
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
  Widget build(BuildContext context) => Container(
    width: AppTheme.iconSizeLarge,
    height: AppTheme.iconSizeLarge,
    decoration: const BoxDecoration(
      color: AppTheme.swishBlue,
      shape: BoxShape.circle,
    ),
    child: const Center(
      child: Icon(
        Icons.phone_iphone,
        size: AppTheme.iconSizeSmall,
        color: AppTheme.colorWhite,
      ),
    ),
  );
}
