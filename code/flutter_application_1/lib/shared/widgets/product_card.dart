import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/internet_handler.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat/shopping_item.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

/// Produktbild via nätverket
Widget _productImage(BuildContext context, Product product) {
  final dpr = MediaQuery.devicePixelRatioOf(context);
  final widthPx = (MediaQuery.sizeOf(context).width * dpr / 4).round().clamp(
    180,
    640,
  );

  return Image.network(
    InternetHandler.getImageUrl(product.productId),
    headers: InternetHandler.apiKeyHeader,
    fit: BoxFit.contain,
    filterQuality: FilterQuality.medium,
    gaplessPlayback: true,
    cacheWidth: widthPx,
    errorBuilder:
        (_, __, ___) =>
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
      child: Consumer<ImatDataHandler>(
        builder: (context, iMat, __) {
          final isFav = iMat.isFavorite(product);
          final cartItems = iMat.getShoppingCart().items;

          ShoppingItem? currentItem;
          for (var item in cartItems) {
            if (item.product.productId == product.productId) {
              currentItem = item;
              break;
            }
          }

          final bool inCart = currentItem != null;

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Main Content Column
                Padding(
                  padding: const EdgeInsets.all(AppTheme.paddingMediumSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Image View
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusMedium,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusMedium,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: _productImage(context, product),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 2. Product Name
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                          letterSpacing: -0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // 3. Price & Unit Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${product.price.toStringAsFixed(2)} kr',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            product.unit,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // 4. Interactive Action Button Row
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (
                            Widget child,
                            Animation<double> animation,
                          ) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(
                                scale: animation,
                                child: child,
                              ),
                            );
                          },
                          child:
                              inCart
                                  ? _buildQuantityControl(
                                    iMat,
                                    currentItem,
                                    context,
                                  )
                                  : _buildAddButton(iMat),
                        ),
                      ),
                    ],
                  ),
                ),

                // Floating Favorite Button (Top Right corner overlay)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () => iMat.toggleFavorite(product),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 150),
                          child: Icon(
                            isFav
                                ? Icons.favorite
                                : Icons.favorite_border_rounded,
                            key: ValueKey<bool>(isFav),
                            size: 20,
                            color:
                                isFav
                                    ? AppTheme.accentRed
                                    : Colors.grey.shade400,
                          ),
                        ),
                      ),
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

  Widget _buildAddButton(ImatDataHandler iMat) {
    return ElevatedButton(
      key: const ValueKey('add_btn'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        elevation: 0,
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        iMat.shoppingCartAdd(ShoppingItem(product, amount: 1.0));
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_rounded, size: 20),
          SizedBox(width: 4),
          Text(
            'Köp',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControl(
    ImatDataHandler iMat,
    ShoppingItem item,
    BuildContext context,
  ) {
    return Container(
      key: const ValueKey('qty_control'),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.12),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMicrosizedIconButton(
            icon: Icons.remove_rounded,
            color: AppTheme.accentRed,
            onPressed: () {
              if (item.amount > 1) {
                iMat.shoppingCartAdd(ShoppingItem(product, amount: -1.0));
              } else {
                iMat.shoppingCartRemove(item);
              }
            },
            isLeftEdge: true,
          ),
          Text(
            '${item.amount.toInt()} st',
            style: const TextStyle(
              // Changed from green to a dark charcoal/grey to look cleaner
              color: Color(0xFF1A1A1A),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          _buildMicrosizedIconButton(
            icon: Icons.add_rounded,
            color: AppTheme.primaryGreen,
            onPressed: () {
              iMat.shoppingCartAdd(ShoppingItem(product, amount: 1.0));
            },
            isLeftEdge: false,
          ),
        ],
      ),
    );
  }

  Widget _buildMicrosizedIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required bool isLeftEdge,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isLeftEdge ? 100 : 8),
          bottomLeft: Radius.circular(isLeftEdge ? 100 : 8),
          topRight: Radius.circular(!isLeftEdge ? 100 : 8),
          bottomRight: Radius.circular(!isLeftEdge ? 100 : 8),
        ),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Icon(icon, color: color, size: 20),
        ),
      ),
    );
  }
}

class ProductsBody extends StatelessWidget {
  final ImatDataHandler iMat;
  const ProductsBody({super.key, required this.iMat});

  @override
  Widget build(BuildContext context) {
    final products = iMat.products;
    if (products.isEmpty) {
      return const Center(child: Text("Hittade inga produkter."));
    }

    final screenWidth = MediaQuery.sizeOf(context).width;
    int crossAxisCount = 2;
    if (screenWidth > 900) {
      crossAxisCount = 4;
    } else if (screenWidth > 600) {
      crossAxisCount = 3;
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppTheme.paddingMedium),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: AppTheme.paddingMedium,
        crossAxisSpacing: AppTheme.paddingMedium,
        childAspectRatio: 0.85,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCard(product: products[index]),
    );
  }
}
