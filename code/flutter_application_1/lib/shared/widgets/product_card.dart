import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/internet_handler.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/shared/country_flag.dart';
import 'package:imat_app/shared/widgets/product_add_to_cart_button.dart';
import 'package:imat_app/shared/widgets/product_detail_modal.dart';
import 'package:provider/provider.dart';

/// Produktbild via nätverket
Widget _productImage(BuildContext context, Product product) {
  final dpr = MediaQuery.devicePixelRatioOf(context);
  final widthPx = (MediaQuery.sizeOf(context).width * dpr / 4).round().clamp(
    AppTheme.imageCacheWidthMin,
    AppTheme.imageCacheWidthMax,
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
          final detail = iMat.getDetail(product);

          return Container(
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
              boxShadow: const [
                BoxShadow(
                  color: AppTheme.shadowBlack03,
                  blurRadius: AppTheme.shadowBlurMedium,
                  offset: AppTheme.shadowOffsetMedium,
                ),
                BoxShadow(
                  color: AppTheme.shadowBlack02,
                  blurRadius: AppTheme.shadowBlurTiny,
                  offset: AppTheme.shadowOffsetSmall,
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppTheme.paddingMediumSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap:
                                () => showProductDetailModal(context, product),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppTheme.cardBackground,
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radiusMedium,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radiusMedium,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                          AppTheme.paddingTiny,
                                        ),
                                        child: _productImage(context, product),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppTheme.paddingCompact),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      countryFlagForOrigin(
                                        detail?.origin ?? '',
                                      ),
                                      style: const TextStyle(
                                        fontSize: AppTheme.fontSizeSubtitle,
                                      ),
                                    ),
                                    const SizedBox(width: AppTheme.paddingSmall),
                                    Expanded(
                                      child: Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontSize: AppTheme.fontSizeSubtitle,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.textCharcoal,
                                          letterSpacing: AppTheme.letterSpacingTight,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppTheme.paddingTiny),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${product.price.toStringAsFixed(2)} kr',
                                      style: const TextStyle(
                                        fontSize: AppTheme.fontSizePrice,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textCharcoal,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: AppTheme.paddingMicro,
                                    ),
                                    Text(
                                      product.unit,
                                      style: const TextStyle(
                                        color: AppTheme.grey500,
                                        fontSize: AppTheme.fontSizeCaption,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.paddingMediumSmall),
                      ProductAddToCartButton(product: product),
                    ],
                  ),
                ),
                Positioned(
                  top: AppTheme.paddingSmall,
                  right: AppTheme.paddingSmall,
                  child: Material(
                    type: MaterialType.transparency,
                    child: Ink(
                      decoration: const BoxDecoration(
                        color: AppTheme.favoriteButtonSurface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.shadowBlack05,
                            blurRadius: AppTheme.shadowBlurSmall,
                          ),
                        ],
                      ),
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: AppTheme.colorTransparent,
                        hoverColor: AppTheme.favoriteButtonSurface.withOpacity(0.35),
                        customBorder: const CircleBorder(),
                        onTap: () => iMat.toggleFavorite(product),
                        child: Padding(
                          padding: const EdgeInsets.all(AppTheme.paddingXSmall),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 150),
                            child: Icon(
                              isFav
                                  ? Icons.favorite
                                  : Icons.favorite_border_rounded,
                              key: ValueKey<bool>(isFav),
                              size: AppTheme.iconSizeStandard,
                              color: isFav
                                  ? AppTheme.accentRed
                                  : AppTheme.grey400,
                            ),
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
        childAspectRatio: AppTheme.gridAspectRatioCard,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCard(product: products[index]),
    );
  }
}
