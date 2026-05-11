import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/widgets/product_card.dart';
import 'package:imat_app/widgets/top_navbar.dart';
import 'package:imat_app/widgets/category.dart';
import 'package:imat_app/widgets/shoppingcart.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var iMat = context.watch<ImatDataHandler>();
    var products = iMat.selectProducts;

    return Scaffold(
      body: Column(
        children: [
          TopNavbar(
            searchController: _searchController,
            onHomePressed: () => iMat.selectAllProducts(),
            onShopPressed: () => iMat.selectAllProducts(),
            onFavoritesPressed: () => iMat.selectFavorites(),
            onHistoryPressed: () {},
            onSearchChanged: (value) {
              value.isEmpty ? iMat.selectAllProducts() : iMat.selectSelection(iMat.findProducts(value));
            },
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategorySidebar(iMat: iMat), // Vänsterpanel
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(AppTheme.paddingLarge),
                          child: Text(
                            "Grönsaker > Tyska gurkor",
                            style: TextStyle(fontSize: 18, color: AppTheme.textSecondary),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingLarge),
                            itemCount: products.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: AppTheme.paddingMedium,
                              mainAxisSpacing: AppTheme.paddingMedium,
                              childAspectRatio: 0.65, 
                            ),
                            itemBuilder: (context, index) => ProductCard(products[index], iMat),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CartSidebar(), // Högerpanel
              ],
            ),
          ),
        ],
      ),
    );
  }
}