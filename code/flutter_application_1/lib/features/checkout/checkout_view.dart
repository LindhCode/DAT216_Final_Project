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
  const CheckoutView({super.key});

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
  int _paymentMethod = 1;
  final _cardFirstCtrl = TextEditingController();
  final _cardLastCtrl = TextEditingController();
  final _cardNumberCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvcCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Förifyll data från kunden om den finns
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final customer = context.read<ImatDataHandler>().getCustomer();
      _firstNameCtrl.text = customer.firstName;
      _lastNameCtrl.text = customer.lastName;
      _addressCtrl.text = customer.address;
      _postCodeCtrl.text = customer.postCode;
      _cityCtrl.text = customer.postAddress;
    });
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    }
  }

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();

    return Column(
      children: [
        step_indicator.CheckoutStepIndicator(currentStep: _currentStep),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.paddingInset),
            child: Center(child: _buildStepContent(iMat)),
          ),
        ),
      ],
    );
  }

  Widget _buildStepContent(ImatDataHandler iMat) {
    switch (_currentStep) {
      case 0:
        return Step1Granskning(iMat: iMat, onNext: _nextStep);
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
        final totalSum = cart.items.fold<double>(
          0.0,
          (sum, item) => sum + item.total,
        );

        return Step4Slutfor(
          iMat: iMat,
          cartTotal: totalSum,
          deliveryCost: 49.0,
          deliveryDate: 'Idag, 14:00 - 16:00',
          paymentLabel:
              _paymentMethod == 1
                  ? 'Bankkort'
                  : (_paymentMethod == 0 ? 'Klarna' : 'Swish'),
          onPlaceOrder: () {
            // Här utförs själva köpet
            // iMat.placeOrder(); // Antag att denna metod rensar korgen och skapar order

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tack för din beställning!'),
                backgroundColor: CheckoutTheme.green,
              ),
            );

            // Starta om appen på "Historik"-sidan (index 2 i MainView)
            // Detta kräver att du har tillgång till setState i MainView,
            // men för enkelhetens skull kan vi navigera användaren till början.
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/', (route) => false);
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
