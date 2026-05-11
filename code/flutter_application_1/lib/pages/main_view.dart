import 'package:flutter/material.dart';
import 'package:imat_app/app_theme.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:imat_app/widgets/product_card.dart';
import 'package:imat_app/widgets/top_navbar.dart';
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

  // Hjälpmetod för att nollställa sökning och visa alla produkter
  void _resetAndShowAll(ImatDataHandler iMat) {
    _searchController.clear();
    iMat.selectAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    // Vi använder context.watch för att bygga om sidan när data ändras
    final iMat = context.watch<ImatDataHandler>();
    final products = iMat.selectProducts;
    final spacing = AppTheme.paddingSmall;

    return Scaffold(
      body: Column(
        children: [
          // Navigationsfältet högst upp
          TopNavbar(
            searchController: _searchController,

            // Klick på loggan eller "Handla" återställer filtret
            onHomePressed: () => _resetAndShowAll(iMat),
            onShopPressed: () => _resetAndShowAll(iMat),

            // Visar endast favoriter
            onFavoritesPressed: () {
              _searchController.clear();
              iMat.selectFavorites();
            },

            // DENNA ÄR ÄNDRAD: Navigerar nu till historiksidan
            onHistoryPressed: () {
              Navigator.pushNamed(context, '/history');
            },

            // Hanterar sökning i realtid
            onSearchChanged: (value) {
              if (value.trim().isEmpty) {
                iMat.selectAllProducts();
              } else {
                iMat.selectSelection(iMat.findProducts(value));
              }
            },
          ),

          // Rutnätet med produkter
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(spacing),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 kolumner
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: 4 / 3, // Gör korten rektangulära
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  // Returnerar ditt egna produktkort
                  return ProductCard(product, iMat);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}