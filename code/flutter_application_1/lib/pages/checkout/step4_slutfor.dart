import 'package:flutter/material.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'checkout_theme.dart';
import 'checkout_widgets.dart';

class Step4Slutfor extends StatelessWidget {
  final ImatDataHandler iMat;
  final double cartTotal;
  final double deliveryCost;
  final String deliveryDate;
  final String paymentLabel;
  final VoidCallback onPlaceOrder;

  const Step4Slutfor({
    super.key,
    required this.iMat,
    required this.cartTotal,
    required this.deliveryCost,
    required this.deliveryDate,
    required this.paymentLabel,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    // Hämtar existerande data
    final cart = iMat.getShoppingCart();
    final customer = iMat.getCustomer();
    final total = cartTotal + deliveryCost;

    // Prisformatering till SEK (t.ex. 1060,39 kr)
    String format(double val) => '${val.toStringAsFixed(2).replaceAll('.', ',')} kr';

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              '4. Slutför',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: CheckoutTheme.textDark),
            ),
          ),
          const SizedBox(height: 24),

          // ── Varukorg CARD (matcha image_3.png) ──
          CheckoutCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Varukorg',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SummaryRow('Antal varor', '${cart.items.length}'),
                SummaryRow(
                  'Pris',
                  format(cartTotal),
                  bold: true,
                ),
              ],
            ),
          ),

          // ── Leverans CARD (matcha image_3.png) ──
          CheckoutCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Leverans',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SummaryRow('Datum', deliveryDate),
                SummaryRow('Ort', customer.postAddress, grey: true), // Grå matcha bild
                SummaryRow('Postkod', customer.postCode, grey: true),
                SummaryRow('Adress', customer.address, grey: true),
                SummaryRow(
                  'Pris',
                  format(deliveryCost),
                  bold: true,
                ),
              ],
            ),
          ),

          // ── Betalning CARD (matcha image_3.png) ──
          CheckoutCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Betalning',
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SummaryRow('Metod', paymentLabel),
                SummaryRow(
                  'Att betala',
                  format(total),
                  bold: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── Big green CTA Button (matcha image_3.png) ──
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPlaceOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: CheckoutTheme.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 1,
              ),
              child: const Text('Slutför beställning', 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}