  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:imat_app/model/imat_data_handler.dart';

import 'checkout_theme.dart';
import 'checkout_widgets.dart';

// Vi använder "as" för att undvika namnkonflikten du får
import 'checkout_top_bar.dart' as top_bar;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final iMat = Provider.of<ImatDataHandler>(context, listen: false);
      final customer = iMat.getCustomer();
      final card = iMat.getCreditCard();

      if (customer != null) {
        setState(() {
          _firstNameCtrl.text = customer.firstName;
          _lastNameCtrl.text = customer.lastName;
          _addressCtrl.text = customer.address;
          _postCodeCtrl.text = customer.postCode;
          _cityCtrl.text = customer.postAddress;
          _cardFirstCtrl.text = customer.firstName;
          _cardLastCtrl.text = customer.lastName;
        });
      }
      if (card != null) {
        setState(() {
          _cardNumberCtrl.text = card.cardNumber;
        });
      }
    });
  }

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

  void _nextStep() => setState(() => _currentStep++);
  void _prevStep() => setState(() => _currentStep--);

  @override
  Widget build(BuildContext context) {
    final iMat = Provider.of<ImatDataHandler>(context);

    return Scaffold(
      backgroundColor: CheckoutTheme.bg,
      body: Column(
        children: [
          // Vi använder prefixet här för att lösa felet
          const top_bar.CheckoutTopBar(),
          
          step_indicator.CheckoutStepIndicator(currentStep: _currentStep),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(CheckoutTheme.spaceLarge),
              child: Column(
                children: [
                  if (_currentStep > 0 && _currentStep < 4)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: NavButton(
                          label: '← Gå tillbaka', 
                          onPressed: _prevStep, 
                          outlined: true
                        ),
                      ),
                    ),
                  _buildStep(iMat),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(ImatDataHandler iMat) {
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
        final totalSum = cart.items.fold<double>(0.0, (sum, item) => sum + item.total);

        return Step4Slutfor(
          iMat: iMat,
          cartTotal: totalSum,
          deliveryCost: 49.0,
          deliveryDate: 'Onsdag 24 Maj, 10:00 - 12:00',
          paymentLabel: _paymentMethod == 1 ? 'Bankkort' : (_paymentMethod == 0 ? 'Klarna' : 'Swish'),
          onPlaceOrder: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tack för din beställning!'), backgroundColor: CheckoutTheme.green)
            );
          },
        );
      default:
        return const Center(child: Text("Ett fel uppstod i flödet"));
    }
  }
  }