import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';

class CheckoutTopBar extends StatelessWidget {
  const CheckoutTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1B1B1B),
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.paddingLarge,
        vertical: AppTheme.paddingMediumSmall,
      ),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppTheme.paddingSmall),
              const Text(
                'iMat',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
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
          // Search bar
          Expanded(
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                border: Border.all(color: Colors.white24),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.paddingMediumSmall,
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white54, size: 18),
                  SizedBox(width: AppTheme.paddingSmall),
                  Expanded(
                    child: Text(
                      'Sök bland våra hundratals varor...',
                      style: TextStyle(color: Colors.white38, fontSize: 13),
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
              color: Colors.white,
              size: 16,
            ),
            label: const Text(
              'Logga in',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white54),
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
        Icon(icon, color: Colors.white70, size: 16),
        const SizedBox(width: AppTheme.paddingTiny),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }
}
