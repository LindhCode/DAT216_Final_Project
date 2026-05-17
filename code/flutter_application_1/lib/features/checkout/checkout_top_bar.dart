import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';

class CheckoutTopBar extends StatelessWidget {
  const CheckoutTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.checkoutBarDark,
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.paddingLarge,
        vertical: AppTheme.paddingMediumSmall,
      ),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: AppTheme.checkoutLogoSize,
                height: AppTheme.checkoutLogoSize,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  color: AppTheme.onDarkPrimary,
                  size: AppTheme.iconSizeStandard,
                ),
              ),
              const SizedBox(width: AppTheme.paddingSmall),
              const Text(
                'iMat',
                style: TextStyle(
                  color: AppTheme.onDarkPrimary,
                  fontSize: AppTheme.fontSizeHeading,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: AppTheme.paddingHuge),
          _navItem(Icons.shopping_cart_outlined, 'Handla'),
          const SizedBox(width: AppTheme.paddingLarge),
          _navItem(Icons.favorite_border, 'Mina Favoriter'),
          const SizedBox(width: AppTheme.paddingLarge),
          Expanded(
            child: Container(
              height: AppTheme.buttonHeightSmall,
              decoration: BoxDecoration(
                color: AppTheme.onDarkSurface,
                borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                border: Border.all(color: AppTheme.onDarkBorder),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.paddingMediumSmall,
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.search,
                    color: AppTheme.onDarkMuted,
                    size: AppTheme.iconSizeMedium,
                  ),
                  SizedBox(width: AppTheme.paddingSmall),
                  Expanded(
                    child: Text(
                      'Sök bland våra hundratals varor...',
                      style: TextStyle(
                        color: AppTheme.onDarkHint,
                        fontSize: AppTheme.fontSizeSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppTheme.paddingLarge),
          _navItem(Icons.history, 'Min Historik'),
          const Spacer(),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.person_outline,
              color: AppTheme.onDarkPrimary,
              size: AppTheme.iconSizeSmall,
            ),
            label: const Text(
              'Logga in',
              style: TextStyle(
                color: AppTheme.onDarkPrimary,
                fontSize: AppTheme.fontSizeSmall,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppTheme.onDarkMuted),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusPill),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.paddingMedium,
                vertical: AppTheme.paddingSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppTheme.onDarkSecondary,
          size: AppTheme.iconSizeSmall,
        ),
        const SizedBox(width: AppTheme.paddingTiny),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.onDarkSecondary,
            fontSize: AppTheme.fontSizeSmall,
          ),
        ),
      ],
    );
  }
}
