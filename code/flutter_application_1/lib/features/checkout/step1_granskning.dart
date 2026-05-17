import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'checkout_theme.dart';
import 'checkout_widgets.dart';

class Step1Granskning extends StatelessWidget {
  final ImatDataHandler iMat;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step1Granskning({
    super.key,
    required this.iMat,
    required this.onNext,
    required this.onBack,
  });

  String _quantityLabel(item) {
    final amount = item.amount;
    final rawUnit = item.product.unit.trim();
    final unit = rawUnit.toLowerCase();

    String amountText() {
      return amount.truncateToDouble() == amount
          ? amount.toInt().toString()
          : amount.toStringAsFixed(2);
    }

    String quantityUnit() {
      if (unit.startsWith('kr/')) {
        return rawUnit.split('/').last;
      }
      if (unit.contains('/')) {
        final parts = rawUnit.split('/');
        if (parts.length == 2 && parts.first.toLowerCase().contains('kr')) {
          return parts.last;
        }
      }
      if (unit.contains('kg')) {
        return 'kg';
      }
      if (unit.contains('st')) {
        return 'st';
      }
      if (unit.contains('förp')) {
        return 'förp';
      }
      return rawUnit;
    }

    final unitLabel = quantityUnit();
    final amountLabel = amountText();

    return unitLabel.isEmpty ? amountLabel : '$amountLabel $unitLabel';
  }

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
                            _quantityLabel(item),
                            style: const TextStyle(
                              color: CheckoutTheme.textMuted,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '${item.total.toStringAsFixed(2)} kr',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 24),
                          ElevatedButton.icon(
                            onPressed: () => iMat.shoppingCartRemove(item),
                            icon: const Icon(Icons.delete_outline, size: 18),
                            label: const Text('Tag bort'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CheckoutTheme.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.paddingSmall,
                                vertical: AppTheme.paddingTiny,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                              ),
                              elevation: 0,
                            ),
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
                        color: Colors.black,
                      ),
                    ),
                  ],
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
                onPressed: onBack,
                outlined: true,
              ),
              ElevatedButton(
                onPressed: cart.items.isEmpty ? null : onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CheckoutTheme.green,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[300],
                  disabledForegroundColor: Colors.grey[600],
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.paddingLarge,
                    vertical: AppTheme.paddingMedium,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: const Text(
                  'Till Leverans >',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
