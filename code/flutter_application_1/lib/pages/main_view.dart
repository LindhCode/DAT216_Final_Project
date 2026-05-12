import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/widgets/product_card.dart';
import 'package:imat_app/widgets/top_navbar.dart';
import 'package:imat_app/pages/account_view.dart';
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

  void _resetAndShowAll(ImatDataHandler iMat) {
    _searchController.clear();
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
        body = GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: 4 / 3,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(product, iMat);
          },
        );
        break;

      case 1:
        body = const Center(child: Text("Favoriter"));
        break;

      case 2:
        body = const Center(child: Text("Historik"));
        break;

      case 3:
        body = const AccountView(); // 👈 VIKTIG FIX
        break;

      default:
        body = GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: 4 / 3,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(product, iMat);
          },
        );
    }

    return Scaffold(
      body: Column(
        children: [
          TopNavbar(
            searchController: _searchController,
            selectedIndex: selectedIndex,

            onHomePressed: () {
              setState(() => selectedIndex = 0);
              _resetAndShowAll(iMat);
            },

            onShopPressed: () {
              setState(() => selectedIndex = 0);
              _resetAndShowAll(iMat);
            },

            onFavoritesPressed: () {
              setState(() => selectedIndex = 1);
              _searchController.clear();
              iMat.selectFavorites();
            },

            onHistoryPressed: () {
              setState(() => selectedIndex = 2);
            },

            onAccountPressed: () {
              setState(() => selectedIndex = 3);
            },

            onSearchChanged: (value) {
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