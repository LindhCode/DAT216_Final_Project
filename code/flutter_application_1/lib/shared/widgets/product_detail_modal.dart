import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/model/internet_handler.dart';
import 'package:imat_app/shared/country_flag.dart';
import 'package:imat_app/shared/widgets/product_add_to_cart_button.dart';
import 'package:provider/provider.dart';

void showProductDetailModal(BuildContext context, Product product) {
  showDialog<void>(
    context: context,
    barrierColor: AppTheme.scrimDark,
    builder: (dialogContext) => ProductDetailModal(product: product),
  );
}

class ProductDetailModal extends StatelessWidget {
  final Product product;

  const ProductDetailModal({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();
    final detail = iMat.getDetail(product);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final maxWidth =
        screenWidth > 600 ? AppTheme.modalMaxWidth : screenWidth * 0.94;

    return Center(
      child: Material(
        color: AppTheme.colorTransparent,
        child: Container(
          width: maxWidth,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.9,
          ),
          margin: const EdgeInsets.all(AppTheme.paddingMedium),
          decoration: BoxDecoration(
            color: AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(AppTheme.radiusModal),
            boxShadow: const [
              BoxShadow(
                color: AppTheme.shadowBlack15,
                blurRadius: AppTheme.shadowBlurModal,
                offset: AppTheme.shadowOffsetModal,
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.textMain,
                      side: const BorderSide(color: AppTheme.textMain),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.paddingMedium,
                        vertical: AppTheme.paddingSmall,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: AppTheme.iconSizeMedium,
                    ),
                    label: const Text(
                      'Gå tillbaka',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.paddingMedium),
                SizedBox(
                  height: AppTheme.modalImageHeight,
                  child: _ProductDetailImage(product: product),
                ),
                const SizedBox(height: AppTheme.paddingMedium),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.price.toStringAsFixed(2)} kr',
                      style: const TextStyle(
                        fontSize: AppTheme.fontSizePriceModal,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textCharcoal,
                      ),
                    ),
                    const SizedBox(height: AppTheme.paddingMicro),
                    Text(
                      product.unit,
                      style: const TextStyle(
                        color: AppTheme.grey500,
                        fontSize: AppTheme.fontSizeBody,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.paddingMedium),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      countryFlagForOrigin(detail?.origin ?? ''),
                      style: const TextStyle(fontSize: AppTheme.fontSizeHeading),
                    ),
                    const SizedBox(width: AppTheme.paddingSmall),
                    Expanded(
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: AppTheme.fontSizePriceHero,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textMain,
                          height: AppTheme.lineHeightCompact,
                        ),
                      ),
                    ),
                  ],
                ),
                if (detail != null) ...[
                  const SizedBox(height: AppTheme.paddingSmall),
                  if (detail.brand.isNotEmpty)
                    Text(
                      detail.brand,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textMain,
                      ),
                    ),
                  if (detail.contents.isNotEmpty) ...[
                    const SizedBox(height: AppTheme.paddingTiny),
                    Text(
                      detail.contents,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                  if (product.isEcological) ...[
                    const SizedBox(height: AppTheme.paddingTiny),
                    const Text(
                      'Ekologisk',
                      style: TextStyle(
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w600,
                        fontSize: AppTheme.fontSizeBody,
                      ),
                    ),
                  ],
                  if (detail.description.isNotEmpty) ...[
                    const SizedBox(height: AppTheme.paddingMedium),
                    Text(
                      detail.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: AppTheme.lineHeightRelaxed,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ] else
                  Padding(
                    padding: const EdgeInsets.only(top: AppTheme.paddingMedium),
                    child: Text(
                      'Detaljerad produktinformation är inte tillgänglig.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                const SizedBox(height: AppTheme.paddingLarge),
                ProductAddToCartButton(
                  product: product,
                  height: AppTheme.buttonHeightMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductDetailImage extends StatelessWidget {
  final Product product;

  const _ProductDetailImage({required this.product});

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.devicePixelRatioOf(context);
    final widthPx = (AppTheme.modalMaxWidth * dpr).round().clamp(
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
              Image.asset('assets/images/placeholder.png', fit: BoxFit.contain),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Image.asset('assets/images/placeholder.png', fit: BoxFit.contain);
      },
    );
  }
}
