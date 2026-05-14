import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/internet_handler.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat/shopping_item.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

/// Produktbild via nätverket (ImageCache) så att varje bild inte triggar
/// [ImatDataHandler.notifyListeners] — undviker hela rutnätet som byggs om per bild.
Widget _productImage(BuildContext context, Product product) {
  final dpr = MediaQuery.devicePixelRatioOf(context);
  final widthPx = (MediaQuery.sizeOf(context).width * dpr / 6).round().clamp(120, 480);

  return Image.network(
    InternetHandler.getImageUrl(product.productId),
    headers: InternetHandler.apiKeyHeader,
    fit: BoxFit.cover,
    filterQuality: FilterQuality.medium,
    gaplessPlayback: true,
    cacheWidth: widthPx,
    errorBuilder: (_, __, ___) =>
        Image.asset('assets/images/placeholder.png', fit: BoxFit.cover),
    loadingBuilder: (context, child, progress) {
      if (progress == null) return child;
      return Image.asset('assets/images/placeholder.png', fit: BoxFit.cover);
    },
  );
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Selector<ImatDataHandler, bool>(
        selector: (_, h) => h.isFavorite(product),
        builder: (context, isFav, __) {
          final iMat = context.read<ImatDataHandler>();
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(AppTheme.paddingMediumSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.price.toStringAsFixed(2)} kr',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          product.unit,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? AppTheme.accentRed : Colors.grey,
                      ),
                      onPressed: () => iMat.toggleFavorite(product),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.paddingSmall,
                      ),
                      child: _productImage(context, product),
                    ),
                  ),
                ),
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppTheme.paddingSmall),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      final item = ShoppingItem(product, amount: 1.0);
                      iMat.shoppingCartAdd(item);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.white),
                              const SizedBox(width: AppTheme.paddingCompact),
                              Text('${product.name} lades till i varukorgen'),
                            ],
                          ),
                          backgroundColor: AppTheme.primaryGreen,
                          duration: const Duration(milliseconds: 1500),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                          ),
                          margin: const EdgeInsets.all(AppTheme.paddingInset),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle_outline, size: 18),
                        SizedBox(width: AppTheme.paddingSmall),
                        Text(
                          'Lägg till',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
