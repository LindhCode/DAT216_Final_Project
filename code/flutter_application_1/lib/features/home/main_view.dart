import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/features/account/account_view.dart';
import 'package:imat_app/features/checkout/checkout_view.dart';
import 'package:imat_app/features/history/history_page.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/shared/widgets/category.dart';
import 'package:imat_app/shared/widgets/product_card.dart';
import 'package:imat_app/shared/widgets/shoppingcart.dart';
import 'package:imat_app/shared/widgets/top_navbar.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final TextEditingController _searchController = TextEditingController();
  int selectedIndex = 0; // 0=Hem, 1=Favoriter, 2=Historik, 3=Konto, 4=Kassa

  void _resetToHome(BuildContext context) {
    setState(() {
      selectedIndex = 0;
      _searchController.clear();
    });
    context.read<ImatDataHandler>().selectAllProducts();
  }

  /// Byggs om bara när sortiment, urval, favoriter eller varukorg ändras — inte vid varje bild.
  int _homeLayoutRevision(ImatDataHandler h) {
    var sel = 0;
    for (final p in h.selectProducts) {
      sel = 0x3fffffff & (sel * 31 + p.productId);
    }
    var fav = 0;
    for (final p in h.favorites) {
      fav = 0x3fffffff & (fav * 31 + p.productId);
    }
    var cart = 0;
    for (final i in h.getShoppingCart().items) {
      cart = 0x3fffffff & (cart * 31 + i.product.productId + i.amount.round());
    }
    return Object.hash(
      h.products.length,
      h.selectProducts.length,
      sel,
      fav,
      h.favorites.length,
      h.getShoppingCart().items.length,
      cart,
      h.isShowingFavorites,
      h.selectedCategory,
    );
  }

  Widget _buildBody(ImatDataHandler iMat) {
    switch (selectedIndex) {
      case 1:
        final products = iMat.selectProducts;
        return products.isEmpty
            ? const Center(
              child: Text(
                "Inga favoriter hittades.",
                style: TextStyle(fontSize: 18),
              ),
            )
            : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.paddingLarge,
                    vertical: AppTheme.paddingLarge,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Du letar bland: Favoriter',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textMain,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(AppTheme.paddingLarge),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: AppTheme.paddingInset,
                      mainAxisSpacing: AppTheme.paddingInset,
                    ),
                    cacheExtent: 400,
                    itemCount: products.length,
                    itemBuilder:
                        (context, index) => ProductCard(product: products[index]),
                  ),
                ),
              ],
            );
      case 2:
        return const HistoryPage();
      case 3:
        return const AccountView();
      case 4:
        return CheckoutView(
          onNavigateToHistory: (index) {
            setState(() => selectedIndex = index);
          },
        );
      default:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.paddingLarge,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  Text(
                    'Du letar bland:',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(child: _buildBreadcrumbs(iMat.selectedCategory)),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(AppTheme.paddingLarge),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: AppTheme.paddingInset,
                  mainAxisSpacing: AppTheme.paddingInset,
                ),
                cacheExtent: 400,
                itemCount: iMat.selectProducts.length,
                itemBuilder:
                    (context, index) =>
                        ProductCard(product: iMat.selectProducts[index]),
              ),
            ),
          ],
        );
    }
  }

  String _buildBreadcrumbText(String selectedCategory) {
    if (selectedCategory.isEmpty) {
      return 'Du letar bland alla varor';
    }
    final group = getGroupForCategory(selectedCategory);
    if (group != null) {
      return 'Du letar bland: $group > $selectedCategory';
    }
    return 'Du letar bland: $selectedCategory';
  }

  Widget _buildBreadcrumbs(String selectedCategory) {
    if (selectedCategory.isEmpty) {
      return const Text(
        'Alla varor',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppTheme.textMain,
        ),
      );
    }
    final group = getGroupForCategory(selectedCategory);
    if (group != null) {
      return Row(
        children: [
          Text(
            group,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppTheme.textMain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.chevron_right,
              color: AppTheme.textMain,
            ),
          ),
          Text(
            selectedCategory,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppTheme.textMain,
            ),
          ),
        ],
      );
    }
    return Text(
      selectedCategory,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppTheme.textMain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopNavbar(
            searchController: _searchController,
            selectedIndex: selectedIndex,
            onHomePressed: () => _resetToHome(context),
            onShopPressed: () => _resetToHome(context),
            onFavoritesPressed: () {
              setState(() => selectedIndex = 1);
              _searchController.clear();
              context.read<ImatDataHandler>().selectFavorites();
            },
            onHistoryPressed: () => setState(() => selectedIndex = 2),
            onAccountPressed: () => setState(() => selectedIndex = 3),
            onSearchChanged: (value) {
              final iMat = context.read<ImatDataHandler>();
              if (selectedIndex != 0) setState(() => selectedIndex = 0);
              if (value.trim().isEmpty) {
                iMat.selectAllProducts();
              } else {
                iMat.selectSelection(iMat.findProducts(value));
              }
            },
          ),
          Expanded(
            child: Selector<ImatDataHandler, int>(
              selector:
                  (_, h) => Object.hash(_homeLayoutRevision(h), selectedIndex),
              builder: (context, _, __) {
                final iMat = context.read<ImatDataHandler>();
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (selectedIndex == 0) CategorySidebar(iMat: iMat),
                    Expanded(child: _buildBody(iMat)),
                    if (selectedIndex != 4 &&
                        selectedIndex != 3 &&
                        selectedIndex != 2)
                      CartSidebar(
                        onCheckout: () => setState(() => selectedIndex = 4),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
