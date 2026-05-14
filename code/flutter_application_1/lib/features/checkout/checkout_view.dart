import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'checkout_theme.dart';
import 'checkout_step_indicator.dart' as step_indicator;

import 'step1_granskning.dart';
import 'step2_leverans.dart';
import 'step3_betalning.dart';
import 'step4_slutfor.dart';

class CheckoutView extends StatefulWidget {
  final Function(int) onNavigateToHistory;

  const CheckoutView({super.key, required this.onNavigateToHistory});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  int _currentStep = 0;

  // Controllers för leverans
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _postCodeCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  // Betalningsinställningar
  int _paymentMethod = 1; // 0=Klarna, 1=Kort, 2=Swish
  final _cardFirstCtrl = TextEditingController();
  final _cardLastCtrl = TextEditingController();
  final _cardNumberCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvcCtrl = TextEditingController();

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _addressCtrl.dispose();
    _postCodeCtrl.dispose();
    _cityCtrl.dispose();
    _notesCtrl.dispose();
    _cardFirstCtrl.dispose();
    _cardLastCtrl.dispose();
    _cardNumberCtrl.dispose();
    _expiryCtrl.dispose();
    _cvcCtrl.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();

    return Scaffold(
      backgroundColor: CheckoutTheme.bg,
      body: Column(
        children: [
          // Stegmätare högst upp
          step_indicator.CheckoutStepIndicator(currentStep: _currentStep),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.paddingLarge,
                vertical: AppTheme.paddingHuge,
              ),
              child: Center(
                child: _buildStepContent(iMat),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(ImatDataHandler iMat) {
    switch (_currentStep) {
      case 0:
        return Step1Granskning(
          iMat: iMat,
          onNext: _nextStep,
        );
      case 1:
        return Step2Leverans(
          firstNameCtrl: _firstNameCtrl,
          lastNameCtrl: _lastNameCtrl,
          addressCtrl: _addressCtrl,
          postCodeCtrl: _postCodeCtrl,
          cityCtrl: _cityCtrl,
          notesCtrl: _notesCtrl,
          onNext: _nextStep,
        );
      case 2:
        return Step3Betalning(
          paymentMethod: _paymentMethod,
          onMethodChanged: (val) => setState(() => _paymentMethod = val),
          cardFirstCtrl: _cardFirstCtrl,
          cardLastCtrl: _cardLastCtrl,
          cardNumberCtrl: _cardNumberCtrl,
          expiryCtrl: _expiryCtrl,
          cvcCtrl: _cvcCtrl,
          onNext: _nextStep,
        );
      case 3:
        final cart = iMat.getShoppingCart();
        final totalSum = iMat.shoppingCartTotal();

        return Step4Slutfor(
          iMat: iMat,
          cartTotal: totalSum,
          deliveryCost: 49.0,
          deliveryDate: 'Idag, 14:00 - 16:00',
          paymentLabel: _paymentMethod == 1 
              ? 'Bankkort' 
              : (_paymentMethod == 0 ? 'Klarna' : 'Swish'),
          onPlaceOrder: () async {
            try {
              // 1. Genomför beställningen (Spara i historik via backend)
              iMat.placeOrder();

              if (mounted) {
                // 2. Visa bekräftelse enligt temat
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: AppTheme.paddingMedium),
                        Text('Tack för din beställning! Ordern har sparats.'),
                      ],
                    ),
                    backgroundColor: AppTheme.primaryGreen,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    ),
                  ),
                );

                // 3. Töm varukorgen
                iMat.shoppingCartClear();

                // 4. Navigera till Historik-sidan
                widget.onNavigateToHistory(2); // Index 2 är historik i MainView
              }
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Kunde inte genomföra ordern. Försök igen.'),
                    backgroundColor: AppTheme.accentRed,
                  ),
                );
              }
            }
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}