import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';

class TopNavbar extends StatefulWidget {
  final TextEditingController searchController;
  final int selectedIndex;

  final VoidCallback onHomePressed;
  final VoidCallback onShopPressed;
  final VoidCallback onFavoritesPressed;
  final VoidCallback onHistoryPressed;
  final VoidCallback onAccountPressed;

  final ValueChanged<String>? onSearchChanged;

  const TopNavbar({
    super.key,
    required this.searchController,
    required this.selectedIndex,
    required this.onHomePressed,
    required this.onShopPressed,
    required this.onFavoritesPressed,
    required this.onHistoryPressed,
    required this.onAccountPressed,
    this.onSearchChanged,
  });

  @override
  State<TopNavbar> createState() => _TopNavbarState();
}

class _TopNavbarState extends State<TopNavbar> {
  int hoveredIndex = -1;

  Widget navItem({
    required int index,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isAccount = false,
  }) {
    final isHovered = hoveredIndex == index;
    final isSelected = widget.selectedIndex == index;

    if (isAccount) {
      return MouseRegion(
        onEnter: (_) => setState(() => hoveredIndex = index),
        onExit: (_) => setState(() => hoveredIndex = -1),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radiusRound),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.paddingMedium,
              vertical: AppTheme.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: isHovered ? AppTheme.darkGreen : AppTheme.primaryGreen,
              borderRadius: BorderRadius.circular(AppTheme.radiusRound),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.person,
                  color: AppTheme.onDarkPrimary,
                  size: AppTheme.iconSizeNav,
                ),
                SizedBox(width: AppTheme.paddingXSmall),
                Text(
                  "Mitt konto",
                  style: TextStyle(
                    color: AppTheme.onDarkPrimary,
                    fontSize: AppTheme.fontSizeSubtitle,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = -1),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.paddingCompact,
            vertical: AppTheme.paddingSmall,
          ),
          decoration: BoxDecoration(
            color: isHovered ? AppTheme.onDarkSubtle : AppTheme.colorTransparent,
            border:
                isSelected
                    ? const Border(
                      bottom: BorderSide(
                        color: AppTheme.onDarkPrimary,
                        width: AppTheme.borderBold,
                      ),
                    )
                    : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppTheme.onDarkPrimary,
                size: AppTheme.iconSizeLarge,
              ),
              const SizedBox(width: AppTheme.paddingXSmall),
              Text(
                label,
                style: const TextStyle(
                  color: AppTheme.onDarkPrimary,
                  fontSize: AppTheme.fontSizeSubtitle,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.navbarHeight,
      color: AppTheme.navbarDark,
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingMedium),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            onTap: widget.onHomePressed,
            child: Padding(
              padding: const EdgeInsets.only(right: AppTheme.paddingMedium),
              child: Image.asset(
                'assets/images/imat_logo.png',
                height: AppTheme.navbarLogoHeight,
              ),
            ),
          ),
          navItem(
            index: 0,
            icon: Icons.shopping_cart_outlined,
            label: "Handla",
            onTap: widget.onShopPressed,
          ),
          const SizedBox(width: AppTheme.paddingMedium),
          navItem(
            index: 1,
            icon: Icons.favorite_border,
            label: "Favoriter",
            onTap: widget.onFavoritesPressed,
          ),
          const SizedBox(width: AppTheme.paddingMedium),
          Expanded(
            child: Center(
              child: SizedBox(
                width: AppTheme.searchBarWidth,
                height: AppTheme.searchBarHeight,
                child: TextField(
                  controller: widget.searchController,
                  onChanged: widget.onSearchChanged,
                  decoration: InputDecoration(
                    hintText: "Sök produkter...",
                    filled: true,
                    fillColor: AppTheme.cardBackground,
                    suffixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.paddingInset,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppTheme.paddingMedium),
          navItem(
            index: 2,
            icon: Icons.history,
            label: "Historik",
            onTap: widget.onHistoryPressed,
          ),
          const SizedBox(width: AppTheme.paddingMedium),
          navItem(
            index: 3,
            icon: Icons.person,
            label: "Mitt konto",
            onTap: widget.onAccountPressed,
            isAccount: true,
          ),
        ],
      ),
    );
  }
}
