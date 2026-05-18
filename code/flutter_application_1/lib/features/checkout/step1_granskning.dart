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
    return amount.truncateToDouble() == amount
        ? amount.toInt().toString()
        : amount.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final cart = iMat.getShoppingCart();
    final totalSum = cart.items.fold<double>(
      0.0,
      (sum, item) => sum + item.total,
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppTheme.contentWidthCheckout),
      child: Column(
        children: [
          const Text(
            '1. Granskning',
            style: TextStyle(
              fontSize: AppTheme.fontSizeDisplaySmall,
              fontWeight: FontWeight.bold,
              color: CheckoutTheme.textDark,
            ),
          ),
          const SizedBox(height: AppTheme.paddingLarge),

          CheckoutCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dina varor',
                  style: TextStyle(
                    fontSize: AppTheme.fontSizeHeadingSmall,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textMain,
                  ),
                ),
                const SizedBox(height: AppTheme.paddingMedium),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.paddingMedium,
                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Produkt',
                          style: TextStyle(
                            fontSize: AppTheme.fontSizeSubtitle,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textMain,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppTheme.checkoutPriceColumnWidth,
                        child: Text(
                          'Pris',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: AppTheme.fontSizeSubtitle,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textMain,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppTheme.checkoutQuantityColumnWidth,
                        child: Text(
                          'Antal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: AppTheme.fontSizeSubtitle,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textMain,
                          ),
                        ),
                      ),
                      SizedBox(width: AppTheme.checkoutActionColumnWidth),
                    ],
                  ),
                ),

                const Divider(height: AppTheme.paddingMedium),

                if (cart.items.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppTheme.paddingInset),
                    child: Center(child: Text("Din varukorg är tom.")),
                  )
                else
                  ...cart.items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.paddingMedium,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.product.name,
                              style: const TextStyle(
                                fontSize: AppTheme.fontSizeBodyLarge,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textMain,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: AppTheme.checkoutPriceColumnWidth,
                            child: Text(
                              '${item.total.toStringAsFixed(2)} kr',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppTheme.textMain,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: AppTheme.checkoutQuantityColumnWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  iconSize: 26,
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: AppTheme.textSecondary,
                                  ),
                                  onPressed: () {
                                    iMat.shoppingCartUpdate(item, delta: -1.0);
                                  },
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _quantityLabel(item),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppTheme.textMain,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  iconSize: 26,
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: AppTheme.textSecondary,
                                  ),
                                  onPressed: () {
                                    iMat.shoppingCartUpdate(item, delta: 1.0);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: AppTheme.checkoutActionColumnWidth,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: AppTheme.paddingMedium,
                              ),
                              child: ElevatedButton.icon(
                                onPressed: () => iMat.shoppingCartRemove(item),
                                icon: const Icon(
                                  Icons.delete_outline,
                                  size: AppTheme.iconSizeMedium,
                                ),
                                label: const Text('Tag bort'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CheckoutTheme.red,
                                  foregroundColor: AppTheme.colorWhite,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.paddingSmall,
                                    vertical: AppTheme.paddingTiny,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppTheme.radiusRound,
                                    ),
                                  ),
                                  elevation: AppTheme.elevationNone,
                                ),
                              ),
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
                        fontSize: AppTheme.fontSizeSubtitle,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${totalSum.toStringAsFixed(2)} kr',
                      style: const TextStyle(
                        fontSize: AppTheme.fontSizeTitle,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.colorBlack,
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
                  foregroundColor: AppTheme.colorWhite,
                  disabledBackgroundColor: AppTheme.buttonDisabledBackground,
                  disabledForegroundColor: AppTheme.buttonDisabledForeground,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.paddingLarge,
                    vertical: AppTheme.paddingMedium,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  ),
                ),
                child: const Text(
                  'Till Leverans >',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppTheme.fontSizeBodyLarge,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
