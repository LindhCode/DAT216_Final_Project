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
      child: Consumer<ImatDataHandler>(
        builder: (context, iMat, __) {
          final isFav = iMat.isFavorite(product);
          
          // HÄR ÄR FIXEN: Vi går via getShoppingCart() för att nå .items
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
                  color: Colors.black.withOpacity(0.05),
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
                  height: 40,
                  child: inCart 
                    ? _buildQuantityControl(iMat, currentItem!)
                    : _buildAddButton(iMat),
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
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
        ),
        elevation: 0,
      ),
      onPressed: () {
        // Använder din handlers shoppingCartAdd
        iMat.shoppingCartAdd(ShoppingItem(product, amount: 1.0));
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_outline, size: 18),
          SizedBox(width: AppTheme.paddingSmall),
          Text('Lägg till', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildQuantityControl(ImatDataHandler iMat, ShoppingItem item) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 90, 119, 74),
        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.remove, color: Colors.white, size: 20),
            onPressed: () {
              if (item.amount > 1) {
                // Minska med 1 via shoppingCartAdd
                iMat.shoppingCartAdd(ShoppingItem(product, amount: -1.0));
              } else {
                // Ta bort helt
                iMat.shoppingCartRemove(item);
              }
            },
          ),
          Text(
            '${item.amount.toInt()} st',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.add, color: Colors.white, size: 20),
            onPressed: () {
              iMat.shoppingCartAdd(ShoppingItem(product, amount: 1.0));
            },
          ),
        ],
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
    return GridView.builder(
      padding: const EdgeInsets.all(AppTheme.paddingMedium),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 240,
        mainAxisSpacing: AppTheme.paddingMedium,
        crossAxisSpacing: AppTheme.paddingMedium,
        childAspectRatio: 0.72, 
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCard(product: products[index]),
    );
  }
}