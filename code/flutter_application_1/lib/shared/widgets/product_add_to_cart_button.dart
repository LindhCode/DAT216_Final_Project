import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/model/imat/product.dart';
import 'package:imat_app/model/imat/shopping_item.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

/// Lägg till-knapp som byter till − antal + när produkten finns i varukorgen.
class ProductAddToCartButton extends StatelessWidget {
  final Product product;
  final double height;

  const ProductAddToCartButton({
    super.key,
    required this.product,
    this.height = AppTheme.buttonHeightCompact,
  });

  static String _cartAmountKey(ImatDataHandler h, int productId) {
    for (final item in h.getShoppingCart().items) {
      if (item.product.productId == productId) {
        return item.amount.toString();
      }
    }
    return '0';
  }

  static String _formatAmount(double amount) {
    if (amount == amount.roundToDouble()) {
      return amount.toInt().toString();
    }
    return amount.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ImatDataHandler, String>(
      selector: (_, h) => _cartAmountKey(h, product.productId),
      builder: (context, amountKey, __) {
        final iMat = context.read<ImatDataHandler>();
        ShoppingItem? currentItem;
        for (final item in iMat.getShoppingCart().items) {
          if (item.product.productId == product.productId) {
            currentItem = item;
            break;
          }
        }

        return SizedBox(
          width: double.infinity,
          height: height,
          child:
              currentItem != null
                  ? _QuantityControl(
                    key: ValueKey('qty_${product.productId}_$amountKey'),
                    product: product,
                    item: currentItem,
                    iMat: iMat,
                  )
                  : _BuyButton(
                    key: ValueKey('buy_${product.productId}'),
                    product: product,
                    iMat: iMat,
                  ),
        );
      },
    );
  }
}

class _BuyButton extends StatelessWidget {
  final Product product;
  final ImatDataHandler iMat;

  const _BuyButton({super.key, required this.product, required this.iMat});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return AppTheme.primaryGreen.withOpacity(0.92);
          }
          return AppTheme.primaryGreen;
        }),
        foregroundColor:
            MaterialStateProperty.all(AppTheme.colorWhite),
        shape: MaterialStateProperty.all(const StadiumBorder()),
        elevation: MaterialStateProperty.all(AppTheme.elevationNone),
        padding: MaterialStateProperty.all(AppTheme.paddingNone),
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return AppTheme.colorWhite.withOpacity(0.08);
          }
          return AppTheme.colorTransparent;
        }),
      ),
      onPressed: () {
        iMat.shoppingCartAdd(ShoppingItem(product, amount: 1.0));
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_rounded, size: AppTheme.iconSizeStandard),
          SizedBox(width: AppTheme.paddingTiny),
          Text(
            'Lägg till',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppTheme.fontSizeBody,
              letterSpacing: AppTheme.letterSpacingWide,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityControl extends StatelessWidget {
  final Product product;
  final ShoppingItem item;
  final ImatDataHandler iMat;

  const _QuantityControl({
    super.key,
    required this.product,
    required this.item,
    required this.iMat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen12,
        borderRadius: BorderRadius.circular(AppTheme.radiusStadium),
        border: Border.all(
          color: AppTheme.primaryGreen25,
          width: AppTheme.borderStandard,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QtyIconButton(
            icon: Icons.remove_rounded,
            color: AppTheme.accentRed,
            isLeftEdge: true,
            onPressed: () {
              if (item.amount > 1) {
                iMat.shoppingCartUpdate(item, delta: -1.0);
              } else {
                iMat.shoppingCartRemove(item);
              }
            },
          ),
          Text(
            ProductAddToCartButton._formatAmount(item.amount),
            style: const TextStyle(
              color: AppTheme.textCharcoal,
              fontWeight: FontWeight.bold,
              fontSize: AppTheme.fontSizeBody,
            ),
          ),
          _QtyIconButton(
            icon: Icons.add_rounded,
            color: AppTheme.primaryGreen,
            isLeftEdge: false,
            onPressed: () {
              iMat.shoppingCartUpdate(item, delta: 1.0);
            },
          ),
        ],
      ),
    );
  }
}

class _QtyIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool isLeftEdge;
  final VoidCallback onPressed;

  const _QtyIconButton({
    required this.icon,
    required this.color,
    required this.isLeftEdge,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: AppTheme.colorTransparent,
        hoverColor: AppTheme.primaryGreen25,
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.paddingBlock,
            vertical: AppTheme.paddingSmall,
          ),
          child: Icon(icon, color: color, size: AppTheme.iconSizeStandard),
        ),
      ),
    );
  }
}