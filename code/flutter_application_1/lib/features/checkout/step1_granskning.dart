import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'checkout_theme.dart';
import 'checkout_widgets.dart';

class Step1Granskning extends StatelessWidget {
  final ImatDataHandler iMat;
  final VoidCallback onNext;

  const Step1Granskning({super.key, required this.iMat, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final cart = iMat.getShoppingCart();
    final totalSum = cart.items.fold<double>(
      0.0,
      (sum, item) => sum + item.total,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 700),
      child: Column(
        children: [
          const Text(
            '1. Granskning',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: CheckoutTheme.textDark,
            ),
          ),
          const SizedBox(height: AppTheme.paddingLarge),

          CheckoutCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dina varor',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                if (cart.items.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: Text("Din varukorg är tom.")),
                  )
                else
                  ...cart.items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.product.name,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          Text(
                            '${item.amount.toInt()} ${item.product.unit}',
                            style: const TextStyle(
                              color: CheckoutTheme.textMuted,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Text(
                            '${item.total.toStringAsFixed(2)} kr',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                const Divider(height: AppTheme.paddingHuge),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Summa varor',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${totalSum.toStringAsFixed(2)} kr',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CheckoutTheme.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppTheme.paddingMedium),
          Align(
            alignment: Alignment.centerRight,
            child: NavButton(
              label: 'Till Leverans >',
              onPressed: cart.items.isEmpty ? () {} : onNext,
            ),
          ),
        ],
      ),
    );
  }
}
