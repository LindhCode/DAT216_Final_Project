import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'checkout_widgets.dart';

class Step2Leverans extends StatelessWidget {
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController addressCtrl;
  final TextEditingController postCodeCtrl;
  final TextEditingController cityCtrl;
  final TextEditingController notesCtrl;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const Step2Leverans({
    super.key,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.addressCtrl,
    required this.postCodeCtrl,
    required this.cityCtrl,
    required this.notesCtrl,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        firstNameCtrl,
        lastNameCtrl,
        addressCtrl,
        postCodeCtrl,
        cityCtrl,
      ]),
      builder: (context, _) {
        bool isValid =
            firstNameCtrl.text.isNotEmpty &&
            lastNameCtrl.text.isNotEmpty &&
            addressCtrl.text.isNotEmpty &&
            postCodeCtrl.text.isNotEmpty &&
            cityCtrl.text.isNotEmpty;

        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Column(
            children: [
              const Text(
                '2. Leverans',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              CheckoutCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Vart ska vi leverera?',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel('Förnamn'),
                              CheckoutTextField(controller: firstNameCtrl),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppTheme.paddingMedium),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel('Efternamn'),
                              CheckoutTextField(controller: lastNameCtrl),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const FieldLabel('Gatuadress'),
                    CheckoutTextField(controller: addressCtrl),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel('Postnummer'),
                              CheckoutTextField(controller: postCodeCtrl),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppTheme.paddingMedium),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel('Ort'),
                              CheckoutTextField(controller: cityCtrl),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const FieldLabel('Övrigt (t.ex. portkod)'),
                    CheckoutTextField(
                      controller: notesCtrl,
                      hint: 'Skriv här...',
                    ),
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
                    label: 'Betalning >',
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
