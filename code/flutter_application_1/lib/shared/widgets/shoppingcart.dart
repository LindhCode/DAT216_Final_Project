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
              const Padding(
                padding: EdgeInsets.all(AppTheme.paddingMedium),
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart_outlined, size: 30),
                    SizedBox(width: AppTheme.paddingCompact),
                    Text(
                      "Min varukorg",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child:
                    items.isEmpty
                        ? const Center(child: Text("Varukorgen är tom"))
                        : ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.paddingMediumSmall,
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
                                          ),
                                        ),
                                        Text(
                                          "${item.product.price.toStringAsFixed(2)} kr",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
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
                                          color: Colors.black54,
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
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.black54,
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
                          ),
                        ),
                        Text(
                          "${iMat.shoppingCartTotal().toStringAsFixed(2)} kr",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.paddingSmall),
                    ElevatedButton(
                      onPressed: items.isEmpty ? null : onCheckout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        minimumSize: Size(
                          double.infinity,
                          AppTheme.paddingWide,
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
                    const SizedBox(height: AppTheme.paddingMediumSmall),
                    ElevatedButton(
                      onPressed:
                          items.isEmpty ? null : () => iMat.shoppingCartClear(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentRed,
                        minimumSize: Size(
                          double.infinity,
                          AppTheme.paddingHero,
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
