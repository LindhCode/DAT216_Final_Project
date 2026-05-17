import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

class CartSidebar extends StatelessWidget {
  final VoidCallback onCheckout;

  const CartSidebar({super.key, required this.onCheckout});

  static String _cartRevision(ImatDataHandler h) {
    final b = StringBuffer();
    for (final i in h.getShoppingCart().items) {
      b.write('${i.product.productId}:${i.amount};');
    }
    return '${h.getShoppingCart().items.length}|$b|${h.shoppingCartTotal().toStringAsFixed(2)}';
  }

  Future<void> _confirmClearCart(BuildContext context, ImatDataHandler iMat) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardBackground,
          title: const Text('Töm varukorgen'),
          content: const Text('Är du säker på att du vill tömma varukorgen?'),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.textSecondary),
                backgroundColor: AppTheme.cardBackground,
                foregroundColor: AppTheme.textMain,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                ),
              ),
              child: const Text('Avbryt'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                ),
              ),
              child: const Text('Ja, jag är säker'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      iMat.shoppingCartClear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ImatDataHandler, String>(
      selector: (_, h) => _cartRevision(h),
      builder: (context, _, __) {
        final iMat = context.read<ImatDataHandler>();
        final items = iMat.getShoppingCart().items;

        return Container(
          width: 300,
          color: AppTheme.sidebarBackground,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.paddingMedium,
                  AppTheme.paddingLarge,
                  AppTheme.paddingMedium,
                  AppTheme.paddingMedium,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: AppTheme.paddingSection,
                    ),
                    const SizedBox(width: AppTheme.paddingSmall),
                    const Text(
                      "Min varukorg",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textMain,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 1),
              Expanded(
                child:
                    items.isEmpty
                        ? const Center(
                          child: Text(
                            "Varukorgen är tom",
                            style: TextStyle(color: AppTheme.textSecondary),
                          ),
                        )
                        : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.paddingMedium,
                                vertical: AppTheme.paddingSmall,
                              ),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppTheme.textMain,
                                          ),
                                        ),
                                        Text(
                                          "${item.product.price.toStringAsFixed(2)} kr",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppTheme.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                          color: AppTheme.textSecondary,
                                        ),
                                        onPressed:
                                            () => iMat.shoppingCartUpdate(
                                              item,
                                              delta: -1.0,
                                            ),
                                      ),
                                      Text(
                                        "${item.amount.toInt()}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.textMain,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                          color: AppTheme.textSecondary,
                                        ),
                                        onPressed:
                                            () => iMat.shoppingCartUpdate(
                                              item,
                                              delta: 1.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
              ),
              Container(
                padding: const EdgeInsets.all(AppTheme.paddingMedium),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Totalt:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textMain,
                          ),
                        ),
                        Text(
                          "${iMat.shoppingCartTotal().toStringAsFixed(2)} kr",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:
                                AppTheme
                                    .textMain, // Ändrad från Colors.green till AppTheme.textMain
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.paddingMedium),
                    ElevatedButton(
                      onPressed: items.isEmpty ? null : onCheckout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        minimumSize: const Size(
                          double.infinity,
                          AppTheme.paddingHero,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusSmall,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Gå till kassan",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: AppTheme.paddingSmall),
                    ElevatedButton(
                      onPressed: items.isEmpty
                          ? null
                          : () => _confirmClearCart(context, iMat),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentRed,
                        minimumSize: const Size(
                          double.infinity,
                          AppTheme.paddingHero,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusSmall,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Töm varukorgen",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
