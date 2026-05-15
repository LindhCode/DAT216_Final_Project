import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'checkout_theme.dart';
import 'checkout_widgets.dart';

class Step4Slutfor extends StatelessWidget {
  final ImatDataHandler iMat;
  final double cartTotal, deliveryCost;
  final String deliveryDate, paymentLabel;
  final VoidCallback onPlaceOrder, onPrev;

  const Step4Slutfor({
    super.key,
    required this.iMat,
    required this.cartTotal,
    required this.deliveryCost,
    required this.deliveryDate,
    required this.paymentLabel,
    required this.onPlaceOrder,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    final total = cartTotal + deliveryCost;

    String format(double val) =>
        '${val.toStringAsFixed(2).replaceAll('.', ',')} kr';

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 700),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              '4. Slutför',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: AppTheme.paddingLarge),
          CheckoutCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Leverans',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SummaryRow('Datum', deliveryDate),
                SummaryRow('Frakt', format(deliveryCost), bold: true),
              ],
            ),
          ),
          CheckoutCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Betalning',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SummaryRow('Metod', paymentLabel),
                SummaryRow('Att betala', format(total), bold: true),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.paddingMediumSmall),
          Row(
            children: [
              NavButton(label: '< Tillbaka', onPressed: onPrev, outlined: true),
              const SizedBox(width: AppTheme.paddingMedium),
              Expanded(
                child: ElevatedButton(
                  onPressed: onPlaceOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CheckoutTheme.green,
                    foregroundColor: Colors.white,
                    elevation: 0, // Remove shadow
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.paddingMedium,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  child: const Text(
                    'Slutför beställning >',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.paddingHuge),
        ],
      ),
    );
  }
}
