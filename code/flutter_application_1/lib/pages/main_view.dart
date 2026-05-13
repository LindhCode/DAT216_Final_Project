import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/widgets/product_card.dart';
import 'package:imat_app/widgets/top_navbar.dart';
import 'package:imat_app/pages/account_view.dart';
import 'package:imat_app/pages/history_page.dart';
import 'package:imat_app/pages/checkout/checkout_view.dart'; // Lagt till
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final TextEditingController _searchController = TextEditingController();
  int selectedIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _resetToHome(ImatDataHandler iMat) {
    setState(() {
      selectedIndex = 0;
      _searchController.clear();
    });
    iMat.selectAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    final iMat = context.watch<ImatDataHandler>();
    final products = iMat.selectProducts;
    final spacing = AppTheme.paddingSmall;

    Widget body;
    switch (selectedIndex) {
      case 0:
      case 1:
        body = GridView.builder(
          padding: EdgeInsets.all(spacing),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            // EXAKT som i din originalkod
            return ProductCard(product: products[index]);
          },
        );
        break;

      case 2:
        body = const HistoryPage();
        break;

      case 3:
        body = const AccountView();
        break;

      case 4: // KASSAN
        body = const CheckoutView();
        break;

      default:
        body = const Center(child: Text("Sidan kunde inte hittas."));
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      // Knappen som tar dig till kassan
      floatingActionButton: (selectedIndex != 4 && iMat.getShoppingCart().items.isNotEmpty)
          ? FloatingActionButton.extended(
              onPressed: () => setState(() => selectedIndex = 4),
              backgroundColor: const Color(0xFF689451),
              icon: const Icon(Icons.shopping_cart_checkout, color: Colors.white),
              label: const Text("TILL KASSAN", style: TextStyle(color: Colors.white)),
            )
          : null,
      body: Column(
        children: [
          TopNavbar(
            searchController: _searchController,
            selectedIndex: selectedIndex,
            onHomePressed: () => _resetToHome(iMat),
            onShopPressed: () => _resetToHome(iMat),
            onFavoritesPressed: () {
              setState(() => selectedIndex = 1);
              _searchController.clear();
              iMat.selectFavorites();
            },
            onHistoryPressed: () => setState(() => selectedIndex = 2),
            onAccountPressed: () => setState(() => selectedIndex = 3),
            onSearchChanged: (value) {
              if (selectedIndex != 0) setState(() => selectedIndex = 0);
              if (value.trim().isEmpty) {
                iMat.selectAllProducts();
              } else {
                iMat.selectSelection(iMat.findProducts(value));
              }
            },
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}